FROM node:16.9.1 AS builder
EXPOSE 3000
WORKDIR /app

# install dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# build
COPY . .
RUN yarn build

# ---

FROM node:16.9.1 AS runner
WORKDIR /app

# copy files
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY . .

CMD ["yarn", "start"]
