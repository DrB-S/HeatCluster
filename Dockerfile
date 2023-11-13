FROM ubuntu:jammy
ARG HEATCLUSTER_VER="0.4.12"
LABEL base.image="ubuntu:jammy"
LABEL dockerfile.version="3"
LABEL software.version="${HEATCLUSTER_VER}"
LABEL version="${HEATCLUSTER_VER}"
LABEL website="https://github.com/DrB-S/HeatCluster"
LABEL license="https://github.com/DrB-S/HeatCluster/blob/master/LICENSE"
LABEL name="heatcluster/${HEATCLUSTER_VER}"
LABEL maintainer="Stephen Beckstrom-Sternberg"
LABEL maintainer.email="stephen.beckstrom-sternberg@azdhs.gov"

# Install Python and pip
RUN apt-get update && apt-get install -y --no-install-recommends \
apt-utils python3 python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install argparse pandas numpy pathlib seaborn matplotlib scipy 

WORKDIR /heatcluster

RUN echo "Installing heatcluster" && echo

COPY . .

ENV PATH="/heatcluster:$PATH"
RUN echo && echo && ls -ltr /heatcluster && echo

RUN echo && echo "Show heatcluster help file and version number:  " && echo && \
python3 HeatCluster.py --help && \
python3 HeatCluster.py --version

RUN echo && echo "Run a test matrix thru the program:" && \
python3 heatcluster.py -i test/snp-dists.txt && echo ""
RUN ls -ltr .|tail && echo ""
