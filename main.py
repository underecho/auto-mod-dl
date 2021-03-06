import sys
import time
import os
import subprocess
import requests
from tqdm import tqdm


# global
download_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'mods')
sleep_time_sec = 1
"""
def download(url_list, dir):
    for url in url_list:
        print(url)
        if not os.path.isfile(os.path.join(dir, url.split("/")[-1])):
            response = requests.get(url)
            with open(os.path.join(dir, url.split("/")[-1].rstrip('\n')), "wb") as handle:
                for data in tqdm(response.iter_content()):
                    handle.write(data)
        else:
            print('skipped: ', url.split("/")[-1].rstrip('\n'))
        time.sleep(sleep_time_sec)
"""
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
        print(download_dir)
    if not os.path.exists(download_dir):
        os.makedirs(download_dir)
    
    url = "https://raw.githubusercontent.com/underecho/auto-mod-dl/main/data/pack.txt"
    r = requests.get(url)
    with open('pack.txt', 'wb') as f:
        f.write(r.content)

    result = subprocess.run('aria2c.exe', '-i pack.txt', '-d', download_dir, shell=True)
    """
    with open('pack.txt', 'r') as f:
        x = f.readlines()
        download(x, download_dir)
    """
    print("Done.")


