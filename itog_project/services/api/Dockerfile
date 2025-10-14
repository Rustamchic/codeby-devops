FROM golang:1.22 AS builder
WORKDIR /src
COPY services/api/go.mod .
RUN go mod download
COPY services/api/ ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /bin/api ./cmd/api
FROM gcr.io/distroless/base-debian12
ENV APP_NAME=myapp-api
EXPOSE 8080
USER 65532:65532
COPY --from=builder /bin/api /api
ENTRYPOINT ["/api"]
