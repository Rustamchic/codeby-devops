# lesson16

## build & push
cd lesson16/alpine && docker build -t rusticmahansy/lesson16:alpine . && docker push rusticmahansy/lesson16:alpine
cd ../debian && docker build -t rusticmahansy/lesson16:debian . && docker push rusticmahansy/lesson16:debian
cd ../app-go && docker build -t rusticmahansy/lesson16:app . && docker push rusticmahansy/lesson16:app

## run
docker run --rm -p 8080:80   rusticmahansy/lesson16:alpine
docker run --rm -p 8081:80   rusticmahansy/lesson16:debian
docker run --rm -p 8082:8080 rusticmahansy/lesson16:app
