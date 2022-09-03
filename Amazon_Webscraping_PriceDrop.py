# Import libraries

from gettext import find
from time import time
from bs4 import BeautifulSoup
import requests
import time
import datetime
import smtplib





# # ---------------Connect to Website-----------------------------

# URL = 'https://www.amazon.in/SQL-Data-Analysis-Techniques-Transforming/dp/9355420358/?_encoding=UTF8&pd_rd_w=MLeej&content-id=amzn1.sym.e0e8ce89-ede3-4c51-b6ad-44989efc8536&pf_rd_p=e0e8ce89-ede3-4c51-b6ad-44989efc8536&pf_rd_r=NY8SJW68V0GDNNWDVB0X&pd_rd_wg=xkVll&pd_rd_r=3a67df63-b87b-4de8-8bb2-353bc8cc1bdc&ref_=pd_gw_ci_mcx_mr_hp_d'

# headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.102 Safari/537.36", "X-Amzn-Trace-Id": "Root=1-6311d6c1-57e670bf5e3f50b241b1d365"}

# page = requests.get(URL, headers = headers)

# soup1 = BeautifulSoup(page.content, "html.parser")
# soup2 = BeautifulSoup(soup1.prettify(), "html.parser")

# title = soup2.find(id = 'productTitle').get_text()
# price = soup2.find(id = 'price').get_text()

# title = title.strip()
# title = title[ : title.find('(')]
# price = price.strip()[1:]






# # ----------------Creating a csv of above data---------------------

# import csv

# # Printing todays date in a variable

# import datetime
# today = datetime.date.today()

# header = ['Title','Price', 'Date']
# data = [title, price, today]
# with open("Record_Daily.csv", "w", newline='', encoding = 'UTF8') as file:
#     writer = csv.writer(file)
#     writer.writerow(header)
#     writer.writerow(data)





# # --------------------The AUTOMATING FUNCTION ------------------------

def Automate_price():

    # Connect to Website

    URL = 'https://www.amazon.in/SQL-Data-Analysis-Techniques-Transforming/dp/9355420358/?_encoding=UTF8&pd_rd_w=MLeej&content-id=amzn1.sym.e0e8ce89-ede3-4c51-b6ad-44989efc8536&pf_rd_p=e0e8ce89-ede3-4c51-b6ad-44989efc8536&pf_rd_r=NY8SJW68V0GDNNWDVB0X&pd_rd_wg=xkVll&pd_rd_r=3a67df63-b87b-4de8-8bb2-353bc8cc1bdc&ref_=pd_gw_ci_mcx_mr_hp_d'
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.102 Safari/537.36", "X-Amzn-Trace-Id": "Root=1-6311d6c1-57e670bf5e3f50b241b1d365"}
    page = requests.get(URL, headers = headers)
    soup1 = BeautifulSoup(page.content, "html.parser")
    soup2 = BeautifulSoup(soup1.prettify(), "html.parser")

    title = soup2.find(id = 'productTitle').get_text()
    price = soup2.find(id = 'price').get_text()

    title = title.strip()
    title = title[ : title.find('(')]
    price = price.strip()[1:]

    ## APPEND to DATA csv 

    import csv
    import datetime

    today = datetime.date.today()
    header = ['Title','Price', 'Date']
    data = [title, price, today]

    with open('Record_Daily.csv', 'a+', newline='', encoding ='UTF8') as oldfile:
        writer = csv.writer(oldfile)
        for i in range(1):
            writer.writerow(data)






#-------------  Here this While loop runs the the function daily and add the price of product to the csv file  ------------------

while(True):
    Automate_price()
    time.sleep(86400)



#I CAN SEE THE PRICE DROP WITH THIS FUNCTIONS ON DAILY BASIS;