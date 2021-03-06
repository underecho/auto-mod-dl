import sys
import time
import os

import requests
import tqdm


# global
download_dir = 'data/temp'
sleep_time_sec = 1

def download(url_list, dir):
    for url in url_list:
        print(url)
        response = requests.get(url, stream=True)
        with open(url.split("/")[-1], "wb") as handle:
            for data in tqdm(response.iter_content()):
                handle.write(data)
        time.sleep(sleep_time_sec)

def check_mc():
    temp_dir = os.path.join(os.environ['APPDATA'], '.minecraft')
    if os.path.exists(temp_dir):
        temp_dir = os.path.join(temp_dir, "EleIndustrial")
        installPath = os.path.join(temp_dir, 'mods')
        if not os.path.exists(temp_dir):
            os.makedirs(temp_dir)
            os.makedirs(installPath)
        return installPath
    return False

if __name__ == "__main__":
    # パスチェック
    path = check_mc()
    if not check_mc():
        print("minecraftのインストール先が変更されているか、インストールされていません。")
        print("スクリプトがある場所にmodをダウンロードします。")
    else:
        download_dir = path
    
    pass