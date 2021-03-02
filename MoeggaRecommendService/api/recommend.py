from surprise import SVD
from surprise import accuracy
from surprise import Dataset,Reader
from surprise.model_selection import train_test_split
import pandas as pd


class RecommendAlgorithm:

    def __init__(self,rating_scale,ratingCsv,itemCsv,itemColumn,ratingColumn=['userId','itemId','rating']):
        self.reader = Reader(line_format='user item rating',sep=',',rating_scale=rating_scale)
        data = Dataset.load_from_file(ratingCsv,reader=self.reader)
        self.train,self.test = train_test_split(data,test_size=0.2)
        self.items = pd.read_csv(itemCsv, names=itemColumn)
        self.ratings = pd.read_csv(ratingCsv, names=ratingColumn)
        self.model=None

    def createModel(self):self.model = SVD()
    def fit(self):self.model.fit(self.train)
    def predict(self)->object:return self.model.test(self.test)
    def evaluate(self,predictions):
        print('모델의 정확도:',end='')
        accuracy.rmse(predictions)

    def makeModel(self):
        self.createModel()
        self.fit()
        predictions=self.predict()
        self.evaluate(predictions)

    def getRatingItems(self,userId):
        itemIds = pd.DataFrame(self.ratings[self.ratings.iloc[:, 0] == userId].iloc[:, 1])
        return itemIds

    def isRating(self,userId,itemId):
        itemIds=self.getRatingItems(userId)
        if not itemIds[itemIds.iloc[:, 0] == itemId].empty:
           return False
        return True

    def showItem(self,itemId):
        return self.items[self.items.iloc[:, 0] == itemId]

    def getNoRatingItem(self,userId):

        ratingItems = self.ratings[self.ratings.iloc[:, 0] == userId].iloc[:, 1].tolist()
        totalItems = self.items.iloc[:, 0].tolist()
        noRatingItems = [item for item in totalItems if item not in ratingItems]

        return noRatingItems

    def recommendItems(self,userId,noRatingItems, n_top=10):
        predictions = [self.model.predict(str(userId), str(itemId)) for itemId in noRatingItems]
        predictions.sort(key=lambda pred: pred.est, reverse=True)
        topPredictions = predictions[:n_top]
        topitemIds = [int(pred.iid) for pred in topPredictions]
        topItemRatings = [pred.est for pred in topPredictions]
        topItemTitles = self.items[self.items.iloc[:,0].isin(topitemIds)].iloc[:, 1]

        return [(ids, rating, title) for ids, rating, title in zip(topitemIds, topItemRatings, topItemTitles)]


if __name__ == '__main__':
    #1. 객체 생성
    recommend = RecommendAlgorithm((0.5, 5),'./rating/rating.csv', './rating/movie/movie.csv',itemColumn=['movieId', 'title','genre'])

    #2. 모델 생성 및 훈련 그리고 예측및 평가
    recommend.makeModel()

    #확인용
    #확인용 첫번째-사용자 아이디가 100인 사람이 평점을 준 아이템들의 목록(리스트)
    itemIds=recommend.getRatingItems(100)
    #확인용 두번째 -사용자 아이디가 100인 사람이 1005번인 아이템에 대한 평점이 있는지 판단하기
    if not recommend.isRating(100,1005):
        print('아이디 100인 사람은 영화 1005에 대한 평점이 없음')
    #3. 사용자 아이디가 100인 사람이 평점을 매기지 않은 아이템들(리스트)
    noRatingItems=recommend.getNoRatingItem(100)
    #4.사용자 아이디가 100인 사람에게 평점을 하지 않은 아이템들 중에서 모델이 예측한 평점이
    #  높은 아이템들을 추천하기
    #topItemPreds=recommend.recommendItems(100, noRatingItems)#디폴트 10개
    topItemPreds=recommend.recommendItems(100,noRatingItems,5)#5개 추천하기

    for item in topItemPreds:
        print('추천 아이템:{} 예측평점:{}'.format(item[2],item[1]))

