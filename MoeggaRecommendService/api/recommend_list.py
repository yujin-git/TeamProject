from flask_restful import Resource,reqparse
from flask import make_response
from api.recommend import RecommendAlgorithm
from api.oracleconn import makeMeetings,makeRatings

#1.Resource 상속받는다
#2.get(),post(),put(),delete()등을 오버라이딩한다
class RecommandList(Resource):

    def __init__(self):

        self.parse = reqparse.RequestParser()
        self.parse.add_argument('low')
        self.parse.add_argument('high')
        self.parse.add_argument('user')
        self.parse.add_argument('count')

    #http 메소드 :get처리용 -추천 목록 반환(select)
    def get(self):
        args = self.parse.parse_args()
        high=int(args['high'])
        low=int(args['low'])
        userId = args['user']
        count = int(args['count'])

        rating = makeRatings()
        item = makeMeetings()

        # 1. 객체 생성
        recommend = RecommendAlgorithm((low, high), rating, item,
                                       itemColumn=['itemId', 'itemName'])

        # 2. 모델 생성 및 훈련 그리고 예측및 평가
        recommend.makeModel()

        noRatingItems = recommend.getNoRatingItem(userId)
        topItemPreds = recommend.recommendItems(userId, noRatingItems,count)  # 5개 추천하기

        recomm = []
        for item in topItemPreds:
            recomm.append({'item':item[0],'rank':item[1]})
            print('추천 아이템:{} 예측평점:{}'.format(item[2], item[1]))
        print(recomm)
        return make_response({'items':recomm})

