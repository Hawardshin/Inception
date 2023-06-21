FROM alpine:3.17

COPY ./conf/default.conf /etc/nginx/http.d
RUN  apk update && apk upgrade && apk add --no-cache nginx && apk add openssl 
# openSSL 을 사용하여 SSL 인증서 생성
RUN  mkdir -p /etc/nginx/ssl && openssl req 
     -x509 \
     -nodes \
     # X.509 : 인증서 생성 관리 표준, -nodes 인증서를 비 암호화
     -days 365 -newkey rsa:2048 \
     # 365일유효기간, RSA, 2048비트 개인키
     -keyout /etc/nginx/ssl/joushin.42.fr.key \
     -out /etc/nginx/ssl/joushin.42.fr.crt \
     -subj "/C=KR/ST=Seoul/O=Gaepo/OU=Develop/CN=JOUSHIN_BLOG" &&\
     # 인증서에 포함될 정보 :  국가(C), 지역(ST), 조직(O), 부서(OU), 일반 이름(CN)
EXPOSE 443


CMD ["nginx", "-g", "daemon off;"]
