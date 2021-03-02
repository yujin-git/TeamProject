import cx_Oracle
from configparser import ConfigParser
import csv,os

def makeRatings():
    config = ConfigParser()
    path=os.path.realpath('api/oracle.ini')
    config.read(path,encoding='utf8')
    conn = cx_Oracle.connect(config['ORACLE']['user'],config['ORACLE']['password'],config['ORACLE']['url'])
    cur = conn.cursor()
    cur.execute('select  id, meetingno, value from star_meeting order by starno')
    rows=cur.fetchall()#리스트 반환 ,각 레코드는 튜플
    #6.자원 반납
    cur.close()
    conn.close()
    path = os.path.realpath('Rating/rating.csv')
    with open(path, 'w', encoding='utf8', newline='') as f:
        writer = csv.writer(f)
        for row in rows:
            writer.writerow(list(row))
    return path

def makeMeetings():
    config = ConfigParser()
    path = os.path.realpath('api/oracle.ini')
    config.read(path,encoding='utf8')
    conn = cx_Oracle.connect(config['ORACLE']['user'],config['ORACLE']['password'],config['ORACLE']['url'])
    cur = conn.cursor()
    cur.execute('select  meetingno, meetingname from meeting order by meetingno')
    rows=cur.fetchall()#리스트 반환 ,각 레코드는 튜플
    #6.자원 반납
    cur.close()
    conn.close()
    path = os.path.realpath('Rating/item.csv')
    with open(path, 'w', encoding='utf8', newline='') as f:
        writer = csv.writer(f)
        for row in rows:
            writer.writerow(list(row))
    return path

if __name__ == '__main__':
    makeRatings()

