FROM fluent/fluentd:v1.16.2-1.1
USER root
RUN gem install fluent-plugin-elasticsearch --no-document --version  5.0.3
RUN gem install fluent-plugin-grok-parser --no-document --version 2.0.0
ADD fluent.conf /fluentd/etc
USER fluent
