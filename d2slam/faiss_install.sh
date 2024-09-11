FAISS_VERSION=1.7.4

cd $HOME/workspace/setup
git clone https://github.com/facebookresearch/faiss.git && \
      cd faiss && git checkout tags/v${FAISS_VERSION} && \
      # cmake -B build -DCMAKE_BUILD_TYPE=Release -DFAISS_OPT_LEVEL=generic -DFAISS_ENABLE_PYTHON=OFF -DBUILD_TESTING=OFF -DFAISS_ENABLE_GPU=OFF . && \ # avx2からgenericに変更したので注意
      cmake -B build -DCMAKE_BUILD_TYPE=Release -DFAISS_ENABLE_PYTHON=OFF -DBUILD_TESTING=OFF -DFAISS_ENABLE_GPU=OFF .
      sudo make -C build -j4 faiss && \
      sudo make -C build -j4 install

sudo rm -r ~/workspace/setup/d2slam/faiss
