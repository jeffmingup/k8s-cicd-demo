FROM golang:1.22 AS builder

WORKDIR /app

COPY go.mod ./
COPY . ./

RUN go build -o server

FROM gcr.io/distroless/base-debian12

WORKDIR /app

COPY --from=builder /app/server ./server

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["./server"]

