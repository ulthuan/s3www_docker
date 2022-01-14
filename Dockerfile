FROM alpine

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG S3WWW_VERSION
RUN PLAT_S3=$(echo $TARGETPLATFORM | sed s/\\//\_/g) \
  && apk add --no-cache curl \
  && curl -L "https://github.com/harshavardhana/s3www/releases/download/v${S3WWW_VERSION}/s3www_${S3WWW_VERSION}_${PLAT_S3}.tar.gz" -o s3www.tar.gz \
  && addgroup -S s3www && adduser -S s3www -G s3www \
  && tar xzvf  s3www.tar.gz -C /usr/local/bin/ \
  && apk del curl

USER s3www

CMD ["/usr/local/bin/s3www"]
