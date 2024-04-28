#Section 1 :
FROM node:alpine as build_phase

WORKDIR '/app'

COPY package.json .
RUN npm install 
COPY . .

RUN npm run build
#the result of the CMD is the build directory inside our WORKDIR!

#Section 2 : 

FROM nginx 

COPY --from=build_phase /app/build /usr/share/nginx/html

# When we start up the nginx image, it already has the default command 
# to start the nginx server (nginx start or smthng like that).
# No need to override the default command since we need the same command 