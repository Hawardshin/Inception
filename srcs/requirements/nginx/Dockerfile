FROM alpine:3.17

RUN  apk update && apk upgrade && apk add --no-cache nginx openssl

COPY ./conf/nginx.conf /etc/nginx/http.d
# openSSL 을 사용하여 SSL 인증서 생성
# X.509 : 인증서 생성 관리 표준, -nodes 인증서를 비 암호화
# 365일유효기간, RSA, 2048비트 개인키
# 인증서에 포함될 정보 :  국가(C), 지역(ST), 조직(O), 부서(OU), 일반 이름(CN)
RUN  mkdir -p /etc/nginx/ssl 
RUN  openssl req -x509 \
     -nodes \
     -days 365 \
     -newkey rsa:2048 \
     -keyout /etc/ssl/private/joushin42.42.fr.key \
     -out /etc/ssl/certs/joushin42.42.fr.crt \
     -subj "/C=KR/ST=Seoul/L=Gaepo/O=42Seoul/OU=Develop/CN=joushin_blog"

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
