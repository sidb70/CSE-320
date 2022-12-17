/**
 * Main program for testing the decoder
 */
#include <stdio.h>
#include "decoder.h"

/*
 * Main
 */
int main()
{
  const char *encoded="\
s2N2sfpsppsk2pNQ2sO2a2pakNsm66pQakN2kOsmappQspf62mNmpOsO2aNa\
aNN2mafmkOs2Osp26NNssNmqssf2k22Nq2a6qs6msm2m6226p22fOpNsOs22\
2mfqfqNmOqQ62Q6Ns222mp2aafsO2spOas2Nfq6kNkpk2k22Op6mq2fQNs22\
2mNOsNm2asmNmNk2NO6ms2as22fNssm6kNO2m62a26sppspfsN2saONaaOfs\
qsO2smsOfk6NNqfmkfsfssm2qO62N2sNqNs6msm2m6O2sN2masQspNpmO6Nq\
NmsN2fmOfkNfQ6NaNs222fk2ms2pNfpm2ma6sasN2m2m2q2OONkmp2aam622\
2fa6Nmfff2ma2aamsfQ62Oa2NNmmOaOssN6NQs2aa2sQ2kk26fksNk6Nsqq2\
2sksNff6k2pm6NmNsNms2NmOm6O2sNsOm6sa22pmq2fN22NO6m2OfONmpOQq\
2fsqmkNasmONO6pQsNaONO6msOfk2m2NNqO22qNq6m66map2sk6aOffk2qQ2\
sO2s66aNk66fQ6kNO2mNN2ms22fqkkOaN26faafqm2spNk2fkNf6kN2Ofskm\
amsfs2f2ffqNsO2ap2as22m22pfNONO2fk2fQNfm2a6OQ2fsO2aNkaq2sNsq\
sOOmspsk2ppm2s22O6qsms2spmNfsfm2pap2sNN2skpsfsONf2s226ms2aq2\
sNNqQ2m2N22spNNm22pNQ6NkpN2qf6NfOpNfONO6f26fs6NsqmOfms2pm6pp\
6asmNmsf2Nmkq2OkkNm2f2kOsfmNm6qsOOf2ffQpfNppkskNON2OmsqaNNNQ\
2fmp26OOOp2mpOfN2akNspQsfQ62OsNkNQq2q2OmsQskfa2mONm26222fkNf\
mNsmq6NqNmNqaNqaNNNmkOmNN2s226ms2sNN2sNqkNO6N2fmm6sksppN6kNN\
qf2qO2mp2as26kpaaN2N22aq2a2p2NO2ffpp6sNapNNOmp22N2Of66NqNsO2\
22p6fsNQq6pmNmkOQ22skpa2NONO2f62mm2kNO6pOaqsakfq2OfQNQsffmN2\
N2Oms6sNQ2m6NspksNsssQ22ms2pN66pka2p6OOQ2maNN2f2sspm2m2kaOqQ\
2kfs2akm6ak";
  char decoded[1000];

  decoder(encoded, decoded, sizeof(decoded));
  printf("%s\n", decoded);
  return 0;
}
