from flask_restful import Resource,reqparse
from flask import make_response,request,jsonify

class WebHook(Resource):

    def post(self):#post요청 처리 오버라이딩
        # 다이얼로그 플로우에서 json으로 응답을 보낸다
        webhook_response = request.get_json(force=True)
        print('[webhook_response]', webhook_response, sep='\n')
        yes_intent = ['네', '예']
        no_intent = ['취소', '아니요']
        # 사용자 질의어가 "네" 혹은 "예"라면
        for yes_query in yes_intent:
            if webhook_response['queryResult']['queryText'].find(yes_query) != -1:
                reply = {'fulfillmentText': 'Yes. Booking is Completed.. Thank You!'}

        for no_query in no_intent:
            if webhook_response['queryResult']['queryText'].find(no_query) != -1:
                reply = {'fulfillmentText': 'Yes. Booking is Canceled. Thank You!'}

        # DialogFlow의 웹후크 호출(POST)로부터 받은 응답 분석후 내가 원하는 대답을
        # 구성후 다시 DialogFlow에  "fulfillmentText"키값으로 반드시 JSON형식으로 전송
        # return jsonify({'fulfillmentText':'웹후크 콜백으로 받은 응답'})#테스트용

        return make_response(jsonify(reply))