import numpy as np
import random
import matplotlib.pyplot as plt
def f(para):  # the function itself
    X = np.array([50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125])
    f_value = np.empty(X.shape[0])
    for idx in range(X.shape[0]):
        f_value[idx] = para[0] * np.exp(para[1] / (X[idx] + para[2]))  # predicted yvalue
        pass
    return f_value
'''
def testf(para):
    global X
    f_value = np.empty(X.shape[0])
    for idx in range(X.shape[0]):
        f_value[idx] = para*X[idx]  # predicted yvalue
        pass
    return f_value
def testF(para):
    global testX, testY
    y_prdt = testf(para[0])
    lsq = sum(np.square(y_prdt - testY))
    return lsq
def testJ(para):
    J=np.array([para[0]])
    return J
'''

def F(para):  # the lsq function
    Y = np.array(
        [34780, 28610, 23650, 19630, 16370, 13720, 11540, 9744, 8261, 7030, 6005, 5147, 4427, 3820, 3307, 2872])
    y_prdt = f(para)
    lsq = sum(np.square(y_prdt - Y))
    return lsq
def J(para):
    X = np.array([50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125])
    Y = np.array(
        [34780, 28610, 23650, 19630, 16370, 13720, 11540, 9744, 8261, 7030, 6005, 5147, 4427, 3820, 3307, 2872])
    a = para[0]
    b = para[1]
    r = para[2]
    J = np.zeros((X.shape[0], 3),dtype='float64')
    for i in range(X.shape[0]):
        J[i,0]=-np.exp(b / (r + X[i]))
        J[i,1]=-np.exp(a*np.exp(b/(r+X[i])))/(r+X[i])
        J[i,2]=1/np.square(r+X[i])*(a*b*np.exp(b/(r+X[i])))
    return J
def gen_command(f,mu1, sigma1, mu2, sigma2 ,mu3 ,sigma3,kmax,iteration=0):# we want the min of the function implmention of cross_entroy_method
    dict = np.zeros((100, 4), dtype='float32')

    for i in range(100):
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
            templist[dict[templist, -1].argmax()] = i
    if iteration >= kmax:
        a = dict[dict[:, -1].argmin(), :]
        #print('Solution: ',a)
        return a  # return value
    # generate new distributionpass
    iteration += 1
    mu1 = np.average(dict[templist, 0])
    sigma1 = np.std(dict[templist, 0])#/iteration
    mu2 = np.average(dict[templist, 1])
    sigma2 = np.std(dict[templist, 1])#/iteration
    mu3 = np.average(dict[templist, 2])
    sigma3 = np.std(dict[templist, 2])#/iteration
    return gen_command(f,mu1, sigma1, mu2, sigma2,mu3 ,sigma3,kmax, iteration)
class LM_method:
    def __init__(self, Func, Xdim, alpha=1, beta=2,gamma=0.5,sigma=0.5):
        # print( Func(np.array([0,0,0])))
        # total initial try of parameters: Xdim+1
        self.alpha = alpha
        self.beta = beta
        self.gamma=gamma
        self.sigma=sigma
        self.Func = Func
        self.Xdim = Xdim
        xdict = np.zeros((Xdim, Xdim + 1), dtype='float64')
        for i in range(Xdim + 1):
            for j in range(Xdim):
                xdict[j, i] = random.gauss(1000, 1000)
                # parameters stored in columns
        print('Para 1: ',xdict[:,0])
        print('Para 2: ', xdict[:, 1])
        print('Para 3: ', xdict[:, 2])
        print('Para 4: ', xdict[:, 3])
        self.xdict = xdict
        self.tempxydict = np.zeros((Xdim + 1, Xdim + 1), dtype='float64')
        self.xydict = np.zeros((Xdim + 1, Xdim + 1), dtype='float64')
        self.tempxydict[range(self.Xdim), :] = self.xdict
        for i in range(self.Xdim + 1):
            self.tempxydict[-1, i] = self.Func(self.xdict[:, i])
        a = self.tempxydict[-1, :].argsort()
        self.xydict = self.tempxydict[:, a]
        # self.xydict[0:3, self.Xdim] the worst point
    def Exe_one_LM(self):
        self.tempxydict[range(self.Xdim), :] = self.xdict
        for i in range(self.Xdim + 1):
            self.tempxydict[-1, i] = self.Func(self.xdict[:, i])
        a = self.tempxydict[-1, :].argsort()
        self.xydict = self.tempxydict[:, a]#1 sort
        self.x1=self.xydict[range(self.Xdim), 0]
        self.y1=self.xydict[-1,0]
        self.cal_ref()  # 2 reflection
        if (self.y1 <= self.y_ref and self.y_ref < self.xydict[-1, self.Xdim - 1]):# 3 Conditional Execution
            self.xydict[range(self.Xdim), self.Xdim] = self.x_ref
            #return
        elif self.y1 > self.y_ref:
            self.expand()#4  Expansion
            # f(x e ) < f(x r )
            if self.y_ref > self.y_expa:#5 Conditional Execution
                self.xydict[range(self.Xdim), self.Xdim] = self.x_expa
            else:
                self.xydict[range(self.Xdim), self.Xdim] = self.x_ref
            #return
        elif self.y_ref >= self.xydict[-1, self.Xdim - 1] and self.y_ref < self.y_worst:
            self.Out_cont() #6
            # f(x oc ) ≤ f(x r )
            if self.y_oc<=self.y_ref:
                self.xydict[range(self.Xdim), self.Xdim]=self.x_oc
                #return
            else :
                self.Shrink()
                #return
        #f(x n+1 ) ≤ f(x r )
        elif self.y_ref>=self.y_worst:#8
            self.In_co()
            if self.y_ic<self.y_worst:#9
                self.xydict[range(self.Xdim),self.Xdim]=self.x_ic
            else:
                self.Shrink()
            pass
        else :
            print('ERROR!!')
        self.xdict=self.xydict[range(self.Xdim), :]
        pass

    def cal_ref(self):
        self.x_worst = self.xydict[range(self.Xdim), self.Xdim]
        self.y_worst=self.Func(self.x_worst)
        x_sum=0
        for i in range(self.Xdim):
            x_sum+=self.xydict[range(self.Xdim),i]
        self.x_bar = 1 / self.Xdim * x_sum
        self.x_ref = self.x_bar + self.alpha * (self.x_bar - self.x_worst)
        self.y_ref = self.Func(self.x_ref)
        pass

    def expand(self):
        self.x_expa = self.x_bar + self.beta * (self.x_ref - self.x_bar)
        self.y_expa = self.Func(self.x_expa)

    def Out_cont(self):
        self.x_oc=self.x_bar+self.gamma*(self.x_ref-self.x_bar)
        self.y_oc=self.Func(self.x_oc)
        pass
    def Shrink(self):
        for i in range(1,self.Xdim+1):
            self.xydict[range(self.Xdim),i]=self.x1+self.sigma*(self.xydict[range(self.Xdim),i]-self.x1)
    def In_co(self):
        self.x_ic=self.x_bar-self.gamma*(self.x_ref-self.x_bar)
        self.y_ic=self.Func(self.x_ic)
    def iteration(self,kmax,tol):
        a=0
        count=0
        for i in range(kmax):
            self.Exe_one_LM()
            '''
            b=a-self.xydict[3,0]
            if b<1:
                count+=1
            if np.mod(count,3)==0:
                for i in range(self.Xdim + 1):
                    for j in range(self.Xdim):
                        self.xdict[j, i] = random.gauss(np.mean(self.xydict[j,:]), 10)
            '''
            if self.xydict[-1,0]<tol:
                print('The solution of the problem is ',self.xydict[range(self.Xdim),0])
                break
            #for m in range(self.Xdim+1):
                #print(self.xydict[range(self.Xdim), m])
            a=self.xydict[-1,0]
            print('Current R2 is: ', self.xydict[-1, 0])
        #print('The solution of the problem is ',self.xydict[range(3),0])
        print('------------------------------------------------')
        print(' ')
        print('The solution of the problem is ', self.xydict[range(self.Xdim), 0])
        print('The R2 of the solution is ',self.xydict[-1,0])
    def secant(self,kmax):#
        # we observed that this function has large gradients, so it's not a good idea to use secant method
        self.F_value = np.zeros(kmax)
        self.F_value[1]=self.xydict[-1,1]
        self.F_value[0]=self.xydict[-1,0]
        self.x_n_itr = np.zeros((self.Xdim, kmax),dtype='float64')
        self.x_n_itr[:,0]=self.x1
        self.x_n_itr[:,1]=self.xydict[range(self.Xdim),1]
        for j in range(2,kmax):
            self.x_n_itr[:,j]=self.x_n_itr[:,j-1]-self.F_value[j-1]*(self.x_n_itr[:,j-1]-self.x_n_itr[:,j-2])/(self.F_value[j-1]-self.F_value[j-2])
            self.F_value[j]=self.Func(self.x_n_itr[:,j])
        print('Solutions: ',self.x_n_itr[:,-1])
        print('R2 value: ',self.F_value[0])
    def LM(self,kmax,Jaco,f,xtol,ytol,F,tor=1e-3):
        k=0
        v=2
        tor=1e-9
        #self.x=self.xydict[range(self.Xdim),0]
        self.J=Jaco(self.x)
        if self.J[1,1]==-np.inf:
            self.J[:,1]=1e8
        self.A=np.dot(self.J.T,self.J)
        if self.Xdim == 1:
            self.g=sum(self.J*f(self.x))
        else:
            self.g = np.dot(self.J.T, f(self.x))
        self.y = self.Func(self.x)
        #found=(np.linalg.norm(self.g)<ytol)
        found=False
        if self.Xdim==1:
            mu=1*self.A
        else:
            #mu=tor*max(np.diag(self.A))
            mu=0
        while not found:
            if k>=kmax:
                break
            k+=1
            if self.Xdim==1:
                h_lm = self.g / (self.A + mu)
            else:
                h_lm = -1e6*np.linalg.solve((self.A + mu * np.eye(self.Xdim)), self.g)
            #print('g as F is: ',self.g)
            if 0:#(np.linalg.norm(h_lm))<xtol:
                found=True
            else:
                x_new=self.x+h_lm
                L0_LM=1/2*np.dot(h_lm.T,(mu*h_lm-self.g))
                rho=(F(self.x)-F(x_new))/L0_LM
                '''
                self.x = x_new
                self.J = Jaco(self.x)
                self.A = np.dot(self.J.T, self.J)
                self.y = self.Func(self.x)
                print('Solution: ', self.x)
                print('R2: ', F(self.x))
                #print('Gain value: ', rho)
                '''
                if rho>0 :
                    self.x=x_new
                    print('--------------------UPDATED--------------------------')
                    self.J = Jaco(self.x)
                    if self.J[1, 1] == -np.inf:
                        self.J[:, 1] = 1e8
                    self.A = np.dot(self.J.T, self.J)
                    self.y=self.Func(self.x)
                    found = (self.Func(self.x) < ytol)
                    mu=mu*max(1/3,1-np.power(2*rho-1,3))
                    v=2

                else:
                    mu=mu/v
                    v=v/2
        print('Solution from LM method: ', self.x)
        print('R2: ', F(self.x))
        #print(k)
        pass
    def LM_secant(self,B0,f,kmax):
        '''
        k=0
        self.x = self.xydict[range(self.Xdim), 0]
        B=B0
        j=0
        g=np.dot(B.T,f(self.x))
        found=False
        while 1:
            if k>=kmax:
                break
            k+=1
        #h=np.linalg.solve(np.dot(B.T,B)+mu*np.eye())
        '''
        # not implemented
    def newton(self,Jaco,kmax):
        '''
        x=np.zeros((self.Xdim,kmax))
        y=np.zeros(kmax)
        x[:,0]=self.xydict[range(3),0]
        for i in range(1,kmax):
            y[i]=self.Func(x[:,])
        '''
        # not implemented
    def Cross(self):#optimization by cross entropy method
        print('Cross Entropy Method: ')
        mu1=np.mean(self.xydict[0,:])
        sigma1=np.var(self.xydict[0,:])
        mu2 = np.mean(self.xydict[1, :])
        sigma2 = np.var(self.xydict[1, :])
        mu3 = np.mean(self.xydict[2, :])
        sigma3 = np.var(self.xydict[2, :])
        a=gen_command(self.Func, mu1, sigma1, mu2, sigma2, mu3, sigma3, 200)
        self.x=a[range(3)]
        print('Solution from Cross entropy method: ',self.x,'with R2: ',a[3])
        pass
if __name__ == '__main__':
    #para = (np.array([  5.60963692e-03  , 6.18134628e+03  , 3.45223632e+02]))
    #print(F(para))
    X = np.array([50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125])
    Y = np.array(
        [34780, 28610, 23650, 19630, 16370, 13720, 11540, 9744, 8261, 7030, 6005, 5147, 4427, 3820, 3307, 2872])
    t = LM_method(F, 3)
    t.iteration(3000,10)
    t.Cross()
    t.LM(1000, J, f,10,10,F)
    #------------------------verify the results---------------
    #LM method and cross entropy does not provide good refine to the solution here.
    # Jacobian has too large value, sometimes cause overflow in calculation.
    para=t.x
    plt.scatter(X,Y,c='r',label='Raw data')
    xaxis=range(50,125)
    yaxis=np.zeros(75)
    a = para[0]
    b = para[1]
    r = para[2]
    for i in range(50,125):#predicted curve
        yaxis[i-50]=a*np.exp(b/(r+i))
    plt.plot(xaxis,yaxis,label='Fitted data')
    plt.legend(loc='best')
    plt.show()

pass
