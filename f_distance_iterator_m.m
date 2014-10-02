function m_distance = f_distance_iterator_m(m_distance,c_distance,U)
% A function which iterates through the matrix m_distance starting with
% cells at c_distance, and fills in all the distances

% First check whether there are still any -1s left
c_minus_sum = sum(sum(m_distance < 0));
if c_minus_sum == 0
    return;
end

% Find the indices of all the cells which are c_distance away from epithelium 
m_distance_new = ones(U,U).*(m_distance == c_distance);

% Get the indices of the cells wanted
m_distanceindices = f_cellindices_all_m(m_distance_new);
cn_dist = size(m_distanceindices,1);

% First make a list of all the indices of 8 NN
m_NN = [];
for i = 1:cn_dist
    m_NN_addition = f_allindices_8neigh_m(m_distanceindices(i,1),m_distanceindices(i,2),U);
    m_NN = [m_NN; m_NN_addition];
end

% Now make the list unique
m_NN = unique(m_NN,'Rows');

% Now iterate through the indices desired and make all their NNs which are yet to be 
% filled in (ie have a value of minus one) equal to (c_distance + 1)
cn_nn = size(m_NN,1);

for i = 1:cn_nn
   if m_distance(m_NN(i,1),m_NN(i,2)) == -1
       m_distance(m_NN(i,1),m_NN(i,2)) = c_distance + 1;
   end
end

m_distance = f_distance_iterator_m(m_distance,c_distance + 1,U);
