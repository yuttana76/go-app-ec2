# Stage 1 : Build (temporary)
FROM golang:1.22.2-bullseye as builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod tidy
COPY . .
RUN go build -o main ./main.go

# Stage 2: Final Image(Slim)
WORKDIR /app
COPY --from=builder /app/main /app/main
RUN chmod +x main
EXPOSE 4040
CMD [ "./main" ]