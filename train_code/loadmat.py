import scipy.io as sio  
data=sio.loadmat('deep_train_200000.mat')  
xx=data['train_set_x']
print type(xx)
