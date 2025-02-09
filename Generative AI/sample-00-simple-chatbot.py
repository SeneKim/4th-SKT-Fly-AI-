import openai
import streamlit as st

# openai api 키
OPENAI_API_KEY='KEEEEEYYY'

# 접속하려는 주소
OPENAI_API_ENDPOINT='AZUREEEEEEEEE'

# 클라우드에서 접속하기 때문에 type 명시 필요
OPENAI_API_TYPE = 'azure'

# 사용하려는 api version
OPENAI_API_VERSION='2023-05-15'

# open api 및 엔드 포인트 지정
openai.api_key = OPENAI_API_KEY
openai.azure_endpoint = OPENAI_API_ENDPOINT
openai.api_type = OPENAI_API_TYPE
openai.api_version = OPENAI_API_VERSION


# header
st.header('Welcome to GPTBot',
          divider='rainbow')

# 일반 text 쓰기
st.write("Please give me any questions!")

# 사용자로부터 입력 받기
query = st.text_input('Q: ')

# 질문 실행을 위한 버튼 생성
# 또한 버튼이 눌렸는지 아닌지를 체크하기 위한 변수 지정
button_click = st.button("Run")

def make_response(question):
    result = openai.chat.completions.create(
    # 내가 대화할 모델을 설정한다. 
    model = 'dev-model',

    # 대화의 온도를 지정해보아요~
    temperature=0.5,

    # 대화는 여러 번 주고 받기 때문에 list로 받는다. 
    # 페르소나 잡아주기: 내가 이야기할 gpt의 정체성, 방향성을 잡아주어야 한다. 
    messages= [
        # role은 모두 딕셔너리 타입!
        # system이라고 적으면 이후 적는 페르소나는 system에 모두 영향이 가게 됨
        {'role': 'system', 
         'content': 'You are a helpful assistant.'},

        # user의 페르소나 정의하기
        {'role': 'user', 
         'content': question}
    ]
)
    return result.choices[0].message.content
    
# 일단은 한 번만 수행해보자
if button_click: 
    # loading 하는 것 구성해보기
    # 답변이 생성될 때까지 로딩 돌아가는 화면 구성
    with st.spinner('Please wait for seconds.'):
        st.write("A: ", make_response(query))
