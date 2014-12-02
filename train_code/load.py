from logistic_sgd import load_data

datasets = load_data('mnist.pkl.gz')
train_set_x, train_set_y = datasets[0]

print train_set_x.shape
print type(train_set_y)
