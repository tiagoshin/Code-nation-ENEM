library(Cubist)
X <- read.csv("C:/Users/Marte/Documents/Projects/Code_nation/X.csv")
X
y <- read.csv("C:/Users/Marte/Documents/Projects/Code_nation/y.csv")
y <- y$NU_NOTA_MT
# y <- data.frame(NU_NOTA_MT= y)
X <- X[,-1] 
model_tree <- cubist(x = X, y = y, committees = 100)
model_tree
summary(model_tree)

library(caret)
grid <- expand.grid(committees = c(1, 10, 50, 100),
                    neighbors = c(0, 5))
set.seed(1)
predi <- train(
  x = X,
  y = y,
  method = "cubist",
  tuneGrid = grid,
  trControl = trainControl(method = "cv")
)
predi



X_test <- read.csv("C:/Users/Marte/Documents/Projects/Code_nation/X_test.csv")
prediction <- predict(model_tree, X_test)
prediction
write.csv(prediction, file="C:/Users/Marte/Documents/Projects/Code_nation/predictions.csv")
