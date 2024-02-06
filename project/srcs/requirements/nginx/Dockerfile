#choose the system our container will be run in (image)
FROM alpine:3.19
#create a new layer for image (with particular setup)
#update all packages and install nginx
RUN	apk update && apk upgrade && apk add --no-cache nginx
#open the port of container to exchange the data
EXPOSE 443
#run nginx inside the container
CMD ["nginx", "-g", "daemon off;"]