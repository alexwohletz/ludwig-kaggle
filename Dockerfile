  
#
#   Ludwig Docker image with full set of pre-requiste packages to support these capabilities with the Kaggle API.
#   text features
#   image features
#   audio features
#   visualizations
#   model serving
#

FROM tensorflow/tensorflow:latest-py3

ARG NB_USER="alex"
ARG NB_UID="1000"
ARG NB_GID="100"

USER root

RUN apt-get -y update && apt-get -y install git libsndfile1 && apt-get -y install unzip

RUN git clone --depth=1 https://github.com/uber/ludwig.git \
    && cd ludwig/ \
    && pip install -r requirements.txt -r requirements_text.txt \
          -r requirements_image.txt -r requirements_audio.txt \
          -r requirements_serve.txt -r requirements_viz.txt \
    && python setup.py install

RUN pip install kaggle


#Added this bit from Jupyter Dockerfile to work out the permissions.
RUN echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    sed -i.bak -e 's/^%admin/#%admin/' /etc/sudoers && \
    sed -i.bak -e 's/^%sudo/#%sudo/' /etc/sudoers && \
    useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    mkdir -p $CONDA_DIR && \
    chown $NB_USER:$NB_GID $CONDA_DIR && \
    chmod g+w /etc/passwd && \
    fix-permissions $HOME && \
    fix-permissions "$(dirname $CONDA_DIR)"

USER $NB_UID

WORKDIR /home/alex

RUN mkdir ~/data && mkdir ~/.kaggle

COPY kaggle.json /home/alex/.kaggle

COPY ./data/ ./data


ENTRYPOINT ["ludwig"]