FROM python/3.9-rc-alpine

ENV APP_ID
ENV INSTALL_ID
ENV APP_PKEY

RUN apk add --update coreutils && rm -rf /var/cache/apk/*
RUN pip install check-in

COPY ./drone.sh /drone.sh

CMD ["/drone.sh", $APP_ID, $INSTALL_ID, $APP_PKEY]
