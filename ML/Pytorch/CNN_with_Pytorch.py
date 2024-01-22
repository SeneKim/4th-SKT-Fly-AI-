import pandas as pd
import torch
from torch.autograd import Variable
import torch.nn as nn
import torch.nn.functional as F

import torchvision
import torchvision.transforms as transforms
from torch.utils.data import Dataset, DataLoa
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline

# CPU 및 GPU 장치 확인
# 일반적으로 하나의 GPU를 사용할 때는 다음과 같은 코드를 이용
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

# Data Downloading
train_dataset = torchvision.datasets.FashionMNIST(r'C:\Users\2022-PC(T)-4\Desktop\Deeplearning_programming_exercise\data\mnist',
                                                  download = True,
                                                  transform = transforms.Compose([transforms.ToTensor()]))
test_dataset = torchvision.datasets.FashionMNIST(r'C:\Users\2022-PC(T)-4\Desktop\Deeplearning_programming_exercise\data\mnist',
                                                  download = True,
                                                  train = False,
                                                  transform = transforms.Compose([transforms.ToTensor()]))

train_loader = torch.utils.data.DataLoader(train_dataset, batch_size=100)
test_loader = torch.utils.data.DataLoader(test_dataset, batch_size=100)

labels_map = {0: 'T-Shirt',
             1: 'Trouser',
             2: 'Pullover',
             3: 'Dress',
             4: 'Coat',
             5: 'Sandal',
             6: 'Shirt',
             7: 'Sneaker',
             8: 'Bag',
             9: 'Ankle Boot' }

fig = plt.figure(figsize = (8,8));
columns = 4;
rows = 5;

    # 랜덤하게 데이터를 뽑아내서 시각화 해보는 것
for i in range(1, columns * rows + 1):
    # train_data에서 랜덤하게 정수를 뽑음
    img_xy = np.random.randint(len(train_dataset))
    # train_dataset을 이용한 3차원 배열을 생성
    
    # train_dataset[img_xy] = 이미지와 레이블을 반환
    # train_dataset[img_xy][0] = 이미지
    # train_dataset[img_xy][0][0, :, :] = 이미지 픽셀 데이터
    img = train_dataset[img_xy][0][0, :, :]
    fig.add_subplot(rows, columns, i)
    plt.title(labels_map[train_dataset[img_xy][1]])
    plt.axis('off')
    plt.imshow(img, cmap = 'gray')

plt.show()

# DNN
class FashionDNN(nn.Module):
    def __init__(self):
        super(FashionDNN, self).__init__()
        self.fc1 = nn.Linear(in_features=784, out_features=256)
        self.drop = nn.Dropout(0.25)
        self.fc2 = nn.Linear(in_features=256, out_features=128)
        self.fc3 = nn.Linear(in_features=128, out_features=64)
        self.fc4 = nn.Linear(in_features=64, out_features=32)
        self.fc5 = nn.Linear(in_features=32, out_features=10)

    def forward(self, input_data):
        out = input_data.view(-1, 784)
        out = F.relu(self.fc1(out))
        out = self.drop(out)
        out = F.relu(self.fc2(out))
        out = F.relu(self.fc3(out))
        out = F.relu(self.fc4(out))
        out = F.relu(self.fc5(out))
        return out
      
learning_rate = 0.001
model = FashionDNN()

# 모델을 GPU 메모리에 보내놔야함
model.to(device) 

criterion = nn.CrossEntropyLoss(); 
optimizer = torch.optim.Adam(model.parameters(), lr = learning_rate)
print(model)

num_epochs = 6
count = 0

loss_list = []
iteration_list = []
accuracy_list = []

predictions_list = []
label_list = []

for epoch in range(num_epochs):
    for images, labels in train_loader:
        # 이미지도 동일하게 GPU 메모리에 올려주어야 함
        images, labels = images.to(device), labels.to(device)

        train = Variable(images.view(100, 1, 28, 28))
        labels = Variable(labels)

        # 학습 데이터를 모델에 적용
        outputs = model(train)
        loss = criterion(outputs, labels)
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
        count += 1

        if not (count % 50):
            total = 0
            correct = 0
            for images, labels in test_loader:
                images, labels = images.to(device), labels.to(device)
                label_list.append(labels)
                test = Variable(images.view(100, 1, 28, 28))     
                outputs = model(test)
    
                # argmax와 동일하게 최대인 값을 뽑아서 GPU 메모리로 넘겨준다. 
                predictions = torch.max(outputs, 1)[1].to(device)
                predictions_list.append(predictions)
                correct += (predictions==labels).sum()
                total += len(labels)
    
            accuracy = correct * 100 / total
            loss_list.append(loss.data)
            iteration_list.append(count)
            accuracy_list.append(accuracy)
    
        if not (count % 500):
            print("Iteration: {}, Loss:{}, Accuracy: {}%".format(count, loss.data, accuracy))


# CNN
class FashionCNN(nn.Module):
    def __init__(self):
        super(FashionCNN, self).__init__()
        self.layer1 = nn.Sequential(
            nn.Conv2d(in_channels = 1, out_channels=32, kernel_size = 3, padding = 1),
            nn.BatchNorm2d(32),
            nn.ReLU(),
            nn.MaxPool2d(kernel_size = 2, stride = 2))

        self.layer2 = nn.Sequential(
            nn.Conv2d(in_channels = 32, out_channels=64, kernel_size = 3),
            nn.BatchNorm2d(64),
            nn.ReLU(),
            nn.MaxPool2d(kernel_size = 2, stride = 2))

        
        self.layer3 = nn.Sequential(
            nn.Conv2d(in_channels = 64, out_channels=128, kernel_size = 3),
            nn.BatchNorm2d(128),
            nn.ReLU(),
            nn.MaxPool2d(kernel_size = 2, stride = 2))


        self.fc1 = nn.Linear(in_features=512, out_features=300)
        self.fc2 = nn.Linear(in_features=300, out_features=120)
        self.fc3 = nn.Linear(in_features=120, out_features=10)


    def forward(self, x):
        out = self.layer1(x)
        out = self.layer2(out)
        out = self.layer3(out)

        # 행렬 크기를 맞춰주기 위해 -> 배치 사이즈 * (6 * 6 = 이미지 사이즈)
        out = out.view(out.size(0), -1)
        out = self.fc1(out)
        out = self.fc2(out)
        out = self.fc3(out) 

        return out

learning_rate = 0.001
model = FashionCNN()
model.to(device)

criterion = nn.CrossEntropyLoss();
optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
print(model)

num_epochs = 10
count = 0
loss_list = []
iteration_list = []
accuracy_list = []

predictions_list = []
labels_list = []

for epoch in range(num_epochs):
    for images, labels in train_loader:
        images, labels = images.to(device), labels.to(device)
    
        train = Variable(images.view(100, 1, 28, 28))
        labels = Variable(labels)
        
        outputs = model(train)
        loss = criterion(outputs, labels)
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
        count += 1
    
        if not (count % 50):    
            total = 0
            correct = 0        
            for images, labels in test_loader:
                images, labels = images.to(device), labels.to(device)
                labels_list.append(labels)            
                test = Variable(images.view(100, 1, 28, 28))            
                outputs = model(test)            
                predictions = torch.max(outputs, 1)[1].to(device)
                predictions_list.append(predictions)
                correct += (predictions == labels).sum()            
                total += len(labels)
            
            accuracy = correct * 100 / total
            loss_list.append(loss.data)
            iteration_list.append(count)
            accuracy_list.append(accuracy)
        
        if not (count % 500):
            print("Iteration: {}, Loss: {}, Accuracy: {}%".format(count, loss.data, accuracy))
