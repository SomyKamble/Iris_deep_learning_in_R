library(keras)

data1<-(iris)
data1<-as.matrix(data1)


split<-sample(1:2,nrow(data1),prob = c(0.8,0.2),replace = T)

train<-data1[split==1,]

test<-data1[split==2,]

trainx<-train[,1:4]
testx<-test[,1:4]

train[,5]<-as.numeric(as.factor(train[,5]))
trainy<-as.numeric(train[,5])

trainy<-trainy-1

testy<-as.numeric(as.factor(test[,5]))
testy<-testy-1


train_label<-to_categorical(trainy,num_classes = 3)
test_label<- to_categorical(testy,num_classes = 3)



model<-keras_model_sequential()

model %>%
  layer_dense(units = 10,activation = 'relu',input_shape = c(4)) %>%
  layer_dense(units = 10, activation = 'relu')%>%
  layer_dense(units = 10, activation = 'relu')%>%
  layer_dense(units = 3, activation = 'softmax')

summary(model)


model %>% compile(
  loss='categorical_crossentropy',
  optimizer=optimizer_rmsprop(),
  metrics=c('accuracy')
)



history <- model %>% fit(trainx,
                         train_label,epochs=200,batch_size=5,validation_split=0.2)

plot(history)

y_data_pred=predict_classes(model,testx)

table(y_data_pred,testy)




