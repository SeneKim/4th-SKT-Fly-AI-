import os
import azure.cognitiveservices.speech as speechsdk
from dotenv import load_dotenv

# .env에 저장된 값들을 로딩한다
load_dotenv()

def recongize_from_microphone():
    # 환경변수 로딩
    speech_config = speechsdk.SpeechConfig(subscription=os.environ.get("SPEECH_KEY"),
                                           region=os.environ.get("SPEECH_REGION"))
    # 이번엔 영어로 수행해보겠다. 언어를 영어로
    speech_config.speech_recognition_language='en-US'


    audio_config = speechsdk.audio.AudioConfig(use_default_microphone=True)
    speech_recoginzer = speechsdk.SpeechRecognizer(speech_config=speech_config, audio_config= audio_config)

    print("텍스트로 변환할 메시지로 마이크를 통해 말하세요.")

    speech_recogintion_result = speech_recoginzer.recognize_once_async().get()
    if speech_recogintion_result.reason == speechsdk.ResultReason.RecognizingSpeech:
        print("음성 인식됨: {}".format(speech_recogintion_result.text))

    elif speech_recogintion_result.reason == speechsdk.ResultReason.NoMatch:
        print("음성 인식 불가: {}".format(speech_recogintion_result.no_match_details))

    elif speech_recogintion_result.reason == speechsdk.ResultReason.Canceled:
        cancellation_details = speech_recogintion_result.cancellation_details
        print("음성 텍스트 변환 취소됨: {}".format(cancellation_details.reason))

        if cancellation_details.reason == speechsdk.CancellationReason.Error:
            print("에러: {}".format(cancellation_details.error_details))
            print("키(key)와 지역(region)을 잘 설정하셨나요?")
        

recongize_from_microphone()
