FROM golang:1.23.4 as builder
WORKDIR /app

COPY . .
RUN go build -o main .

FROM gcr.io/distroless/base

COPY --from=builder /app/main .
COPY --from=builder /app/static ./static

EXPOSE 8080
CMD ["./main"]