import requests
from datetime import datetime
import os

def test_telegram_connection(token, chat_id):
    print("Đang kiểm tra kết nối Telegram...")
    try:
        url = f"https://api.telegram.org/bot{token}/sendMessage"
        data = {
            'chat_id': chat_id,
            'text': f'Test kết nối - {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}'
        }
        response = requests.post(url, data=data)
        if response.status_code == 200:
            print("Kết nối Telegram thành công!")
            return True
        else:
            print(f"Lỗi kết nối Telegram: {response.text}")
            return False
    except Exception as e:
        print(f"Lỗi khi test kết nối Telegram: {str(e)}")
        return False

def send_to_telegram(file_path, token, chat_id):
    print(f"Đang gửi file {file_path} đến Telegram...")
    try:
        # API endpoint để gửi document
        url = f"https://api.telegram.org/bot{token}/sendDocument"
        
        # Kiểm tra file tồn tại
        if not os.path.exists(file_path):
            print(f"Lỗi: Không tìm thấy file {file_path}")
            return False
            
        # Chuẩn bị file để gửi
        with open(file_path, 'rb') as file:
            files = {
                'document': file
            }
            data = {
                'chat_id': chat_id,
                'caption': f'File báo cáo mới - {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}'
            }
            
            # Gửi request
            response = requests.post(url, data=data, files=files)
            
            # Kiểm tra kết quả
            if response.status_code == 200:
                print(f"Đã gửi file {file_path} thành công!")
                return True
            else:
                print(f"Lỗi khi gửi file: {response.text}")
                return False
                
    except Exception as e:
        print(f"Lỗi khi gửi file đến Telegram: {str(e)}")
        return False 