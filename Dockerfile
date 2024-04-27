FROM node AS builder

# Create app directory
WORKDIR /app

RUN --mount=type=secret,id=firebase_key cp /run/secrets/firebase_key /app/firebase_key.json

RUN ls -l /app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./
COPY prisma ./prisma/

# Install app dependencies
RUN npm install

RUN npx prisma generate

COPY . .

RUN npm run build

FROM node

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/firebase_key.json ./dist

EXPOSE 8000
CMD [ "npm", "run", "start:prod" ]