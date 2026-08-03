#!/usr/bin/env python3
import os,requests
base=os.environ['BASE_URL'].rstrip('/');user=os.environ['ADMIN_USER'];password=os.environ['ADMIN_PASSWORD']
page=requests.get(base+'/',timeout=30);assert page.status_code==200 and 'Shiori' in page.text
bad=requests.post(base+'/api/v1/auth/login',json={'username':user,'password':'not-the-password','remember_me':False},timeout=30);assert bad.status_code in (400,401)
login=requests.post(base+'/api/v1/auth/login',json={'username':user,'password':password,'remember_me':False},timeout=30);data=login.json();assert login.status_code==200 and data.get('ok') and data.get('message',{}).get('token')
token=data['message']['token'];me=requests.get(base+'/api/v1/auth/me',headers={'Authorization':'Bearer '+token},timeout=30);data=me.json();account=data.get('message',data);assert me.status_code==200 and data.get('ok') and account['username']==user and account['owner'] is True
print('Shiori smoke checks passed')
