FROM haskell:8.2.2

WORKDIR /app
ADD . /app

RUN stack build

EXPOSE 3000

CMD ["stack", "exec", "api-exe"]