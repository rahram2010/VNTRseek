SET(TRF2PROCLU_SRCS
    trf2proclu-ngs.c
    )
ADD_EXECUTABLE(trf2proclu-ngs.exe ${TRF2PROCLU_SRCS})
TARGET_LINK_LIBRARIES(trf2proclu-ngs.exe m)

INSTALL(TARGETS trf2proclu-ngs.exe
    RUNTIME DESTINATION ${InstallSuffix}
    )

