FROM rust:latest as build
WORKDIR /build
ADD ./ .
RUN cargo build --release --features="dist-client dist-server"

# ---

FROM rust:latest
RUN adduser sccache --disabled-password
USER sccache
COPY --from=build /build/target/release/sccache /build/target/release/sccache-dist /usr/bin
CMD sccache
