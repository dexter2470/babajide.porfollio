import requests
from bs4 import BeautifulSoup
import lxml
import csv
import time
import random

"""its created to scrape data from the bookings.com website"""
text_url = 'https://www.booking.com/searchresults.html?ss=Lagos&ssne=Lagos&ssne_untouched=Lagos&efdco=1&aid=355028&lang=en-us&sb=1&src_elem=sb&src=searchresults&dest_id=-2017355&dest_type=city&checkin=2025-03-01&checkout=2025-03-02&group_adults=2&no_rooms=1&group_children=0&flex_window=1'

header = {'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36'}

def scrappy(site_url, file_name):


    response = requests.get(text_url,headers=header)

    if response.status_code == 200:
        print("connected to the website")
        html_content = response.text

        #create beautifulsoup
        soup = BeautifulSoup(html_content, 'lxml')
        # print(soup.prettify())

        hotel_div = soup.find_all('div', role ='listitem')

        with open('Lagos_Hotel_data.csv','w', encoding= 'utf-8' ) as file_csv:
            writer = csv.writer(file_csv)
        

            writer.writerow(['hotel_name','location','price (NGN)', 'score','reviews','ratings','links'])

            for hotel in hotel_div:
                hotel_name = hotel.find('div', class_="f6431b446c a15b38c233").text.strip()
                if hotel_name:
                    hotel_name
                else:
                    "N/A"
                # print(hotel_name)
                # print("-")

    #.replace('NGN�90', 'NGN') encoding= 'utf-8'
                location = hotel.find('span', class_="aee5343fdb def9bc142a").text.strip()
                if location:
                    location
                else:
                    "N/A"
                # print(location)
                # print("--")

                price = hotel.find('span', class_="f6431b446c fbfd7c1165 e84eb96b1f").text.strip().replace('NGN�',h'NGN')
                if price:
                    price
                else:
                    "N/A"
                # print(price)
                # print("++")

                score = hotel.find('div', class_="a3b8729ab1 d86cee9b25").text.strip().split(" ")[-1]
                if score:
                    score
                else:
                    "N/A"
                # print(score)
                # print("==")

                reviews = hotel.find('div', class_="abf093bdfe f45d8e4c32 d935416c47").text.strip()
                if reviews:
                    reviews
                else:
                    "N/A"
                # print(reviews)
                # print('-')

                ratings = hotel.find('div', class_="a3b8729ab1 e6208ee469 cb2cbb3ccb").text.strip()
                if ratings:
                    ratings
                else:
                    "N/A"
                # print(ratings)
                # print("__")


                link = hotel.find('a', href = True).get('href')
                if link:
                    link
                else:
                    "N/A"
                # print(link)
                # print(":")


                writer.writerow([hotel_name,location,price,score,reviews,ratings,link])

        #print(hotel_div)

    else:
        print(f"connection failed {response.status_code}")

#print(response.status_code)


if __name__ == '__main__':
    url = input('Please enter the URL! :')
    file_name = input('please give the file name! :')

    scrappy(url, file_name)