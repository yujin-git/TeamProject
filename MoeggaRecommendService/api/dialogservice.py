from flask_restful import Resource,reqparse
from flask import make_response,jsonify
import dialogflow
from settings.config import DIALOG_CONFIG

class DialogService(Resource):


    def response_from_dialogflow(self,project_id, session_id, message, language_code):
        # step1. DialogFlow와 사용자가 상호작용할 세션 클라이언트 생성
        session_client = dialogflow.SessionsClient()
        session_path = session_client.session_path(project_id, session_id)
        # projects/프로젝트아이디/agent/sessions/세션아이디 로 생성된다
        print('[session_path]', session_path, sep='\n')
        if message:  # 사용자가 대화를 입력한 경우.대화는 utf-8로 인코딩된 자연어.256자를 넘어서는 안된다
            # step2.사용자 메시지(일반 텍스트)로 TextInput생성
            text_input = dialogflow.types.TextInput(text=message, language_code=language_code)
            print('[text_input]', text_input, sep='\n')
            '''
            text : '사용자가 입력한 대화'
            language_code :'ko'        
            '''
            # step 3. 생성된 TextInput객체로 QueryInput객체 생성(DialogFlow로 전송할 질의 생성)
            query_input = dialogflow.types.QueryInput(text=text_input)
            print('[query_input]', query_input, sep='\n')
            '''
            text {
                    text : '사용자가 입력한 대화'
                    language_code :'ko'
                 }        
            '''
            # step 4. DialogFlow로 SessionsClient객체.detect_intent()메소드로
            #        QueryInput객체를 보내고 다시 봇 응답(Responses섹션에 등록한 대화)을 받는다
            #        즉 A DetectIntentResponse instance반환
            '''
            PermissionDenied : 403 IAM 권한 에러시
            1. GOOGLE DEVELOPER CONSOLE로 검색후 
               좌측 상단 Google APIs 옆 프로젝트 목록에서 해당 프로젝트 선택 
            2. 좌측의 사용자 인증 정보 클릭
            3. 서비스 계정의 이메일 클릭->IAM 및 관리자
            4. IAM 및 관리자 페이지의 좌측의 IAM메뉴 클릭
            5. 상단의  추가 메뉴 클릭
            6. 구성원 항목에는 서비스 계정 생성시 다운받은 mytravelbot-vbem-cf60a98145b6.json파일의 
               "client_email"키의 값을 복사하여 넣는다
               역할 항목에는 "소유자"를 선택하여 넣는다.    

            '''
            response = session_client.detect_intent(session=session_path, query_input=query_input)
            print('[response]', response, sep='\n')
            print('[type(response)]', type(response), sep='\n')  # DetectIntentResponse타입

        return response.query_result.fulfillment_text  # 다이얼로그플로우 봇이 응답한 텍스트

    def post(self):#오버라이딩
        parser = reqparse.RequestParser()
        parser.add_argument('message')
        parser.add_argument('session_id')
        args=parser.parse_args()

        message = args['message']
        session_id=args['session_id']
        project_id  = DIALOG_CONFIG['PROJECT_ID']

        fulfillmentText=self.response_from_dialogflow(project_id,session_id,message,'ko')

        return jsonify({'message': fulfillmentText})



