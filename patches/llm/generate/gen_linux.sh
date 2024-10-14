--- ../ollama-upstream/llm/generate/gen_linux.sh	2024-10-14 20:46:24.295238332 +0300
+++ patches/llm/generate/gen_linux.sh	2024-10-14 20:48:05.890460620 +0300
@@ -79,7 +79,7 @@
         # -DLLAMA_AVX512_VNNI -- 2021 Intel Alder Lake
 
         COMMON_CPU_DEFS="-DCMAKE_POSITION_INDEPENDENT_CODE=on -DLLAMA_NATIVE=off"
-        if [ -z "${OLLAMA_CPU_TARGET}" -o "${OLLAMA_CPU_TARGET}" = "cpu" ]; then
+        if [ -z "${OLLAMA_CPU_TARGET}" ] || echo "${OLLAMA_CPU_TARGET}" | grep -qw 'cpu'; then
             #
             # CPU first for the default library, set up as lowest common denominator for maximum compatibility (including Rosetta)
             #
@@ -94,7 +94,7 @@
             #
             # ARM chips in M1/M2/M3-based MACs and NVidia Tegra devices do not currently support avx extensions.
             #
-            if [ -z "${OLLAMA_CPU_TARGET}" -o "${OLLAMA_CPU_TARGET}" = "cpu_avx" ]; then
+            if [ -z "${OLLAMA_CPU_TARGET}" ] || echo "${OLLAMA_CPU_TARGET}" | grep -qw 'cpu_avx'; then
                 #
                 # ~2011 CPU Dynamic library with more capabilities turned on to optimize performance
                 # Approximately 400% faster than LCD on same CPU
@@ -107,7 +107,7 @@
                 compress_libs
             fi
 
-            if [ -z "${OLLAMA_CPU_TARGET}" -o "${OLLAMA_CPU_TARGET}" = "cpu_avx2" ]; then
+            if [ -z "${OLLAMA_CPU_TARGET}" ] || echo "${OLLAMA_CPU_TARGET}" | grep -qw 'cpu_avx2'; then
                 #
                 # ~2013 CPU Dynamic library
                 # Approximately 10% faster than AVX on same CPU
@@ -149,11 +149,11 @@
     fi
     if [ "${ARCH}" == "arm64" ]; then
         echo "ARM CPU detected - disabling unsupported AVX instructions"
-        
+
         # ARM-based CPUs such as M1 and Tegra do not support AVX extensions.
         #
-        # CUDA compute < 6.0 lacks proper FP16 support on ARM. 
-        # Disabling has minimal performance effect while maintaining compatibility. 
+        # CUDA compute < 6.0 lacks proper FP16 support on ARM.
+        # Disabling has minimal performance effect while maintaining compatibility.
         ARM64_DEFS="-DLLAMA_AVX=off -DLLAMA_AVX2=off -DLLAMA_AVX512=off -DLLAMA_CUDA_F16=off"
     fi
     CMAKE_DEFS="-DLLAMA_CUBLAS=on -DLLAMA_CUDA_FORCE_MMQ=on -DCMAKE_CUDA_ARCHITECTURES=${CMAKE_CUDA_ARCHITECTURES} ${COMMON_CMAKE_DEFS} ${CMAKE_DEFS} ${ARM64_DEFS}"
@@ -165,8 +165,8 @@
     #
     # TODO - in the future we may shift to packaging these separately and conditionally
     #        downloading them in the install script.
-    DEPS="$(ldd ${BUILD_DIR}/lib/libext_server.so )"
-    for lib in libcudart.so libcublas.so libcublasLt.so ; do
+    DEPS="$(ldd ${BUILD_DIR}/lib/libext_server.so)"
+    for lib in libcudart.so libcublas.so libcublasLt.so; do
         DEP=$(echo "${DEPS}" | grep ${lib} | cut -f1 -d' ' | xargs || true)
         if [ -n "${DEP}" -a -e "${CUDA_LIB_DIR}/${DEP}" ]; then
             cp "${CUDA_LIB_DIR}/${DEP}" "${BUILD_DIR}/lib/"
@@ -208,11 +208,11 @@
     # Record the ROCM dependencies
     rm -f "${BUILD_DIR}/lib/deps.txt"
     touch "${BUILD_DIR}/lib/deps.txt"
-    for dep in $(ldd "${BUILD_DIR}/lib/libext_server.so" | grep "=>" | cut -f2 -d= | cut -f2 -d' ' | grep -e rocm -e amdgpu -e libtinfo ); do
-        echo "${dep}" >> "${BUILD_DIR}/lib/deps.txt"
+    for dep in $(ldd "${BUILD_DIR}/lib/libext_server.so" | grep "=>" | cut -f2 -d= | cut -f2 -d' ' | grep -e rocm -e amdgpu -e libtinfo); do
+        echo "${dep}" >>"${BUILD_DIR}/lib/deps.txt"
     done
     # bomb out if for some reason we didn't get a few deps
-    if [ $(cat "${BUILD_DIR}/lib/deps.txt" | wc -l ) -lt 8 ] ; then
+    if [ $(cat "${BUILD_DIR}/lib/deps.txt" | wc -l) -lt 8 ]; then
         cat "${BUILD_DIR}/lib/deps.txt"
         echo "ERROR: deps file short"
         exit 1
