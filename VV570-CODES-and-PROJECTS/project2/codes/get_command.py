import numpy as np
import random

def f(para):  # the function itself
    global X
    f_value = np.empty(X.shape[0])
    for idx in range(X.shape[0]):
        f_value[idx] = para[0] * np.exp(para[1] / (X[idx] + para[2]))  # predicted yvalue
        pass
    return 1*f_value
def F(para):  # the lsq function
    global X, Y
    y_prdt = f(para)
    lsq = sum(np.square(y_prdt - Y))
    return lsq

def gen_command(f,mu1, sigma1, mu2, sigma2 ,mu3 ,sigma3,kmax,iteration=0):# we want the min of the function
    dict = np.empty((100, 4), dtype='float32')
    for i in range(10):
        alpha = random.gauss(mu1, sigma1)
        beta = random.gauss(mu2, sigma2)
        gamma = random.gauss(mu3, sigma3)
        dict[i, range(3)] = [alpha,beta,gamma]
        predict = f(dict[i,range(3)])
        dict[i,-1]=predict
    templist = np.array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=np.int)  # contains only index

    for i in range(10, len(dict[:, 0])):
        if dict[i, -1] < max(dict[templist, -1]):
            # dict[templist, 2].argmax() the max value in templist
            templist[dict[templist, 2].argmax()] = i
    if iteration >= kmax:
        a = dict[dict[:, -1].argmin(), :]

        return a  # return value
    # generate new distributionpass
    iteration += 1
    mu1 = np.average(dict[templist, 0])
    sigma1 = np.var(dict[templist, 0])
    mu2 = np.average(dict[templist, 1])
    sigma2 = np.var(dict[templist, 1])
    mu3 = np.average(dict[templist, 2])
    sigma3 = np.var(dict[templist, 2])
    return gen_command(f,mu1, sigma1, mu2, sigma2,mu3 ,sigma3,kmax, iteration)

if __name__=='__main__':
    # gen_command(3,1,3,1)
    a = gen_command(F,3, 3, 3, 3,3,3,100)
    print(a)
