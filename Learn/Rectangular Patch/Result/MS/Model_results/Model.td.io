!solution_id 17-January-2020  15:51:53

function port input/output: port 1 excited
  parameters
    variable Mt
      value 0.100000E+00
    variable h
      value 0.450000E+01
    variable Gpf
      value 0.100000E+01
    variable Fi
      value 0.125000E+02
    variable Wf
      value 0.870000E+01
    variable Lf
      value 0.315000E+02
    variable W
      value 0.510000E+02
    variable L
      value 0.380000E+02
    port_excited 1
    excitation_label 1
  from frequency
    type  real
    units Hz

  # exp(+iwt) convention used

  to Port 1: Input
    type  complex
    units √W
    parameters
      port_name   1
      port_cutoff 0
      dc_capacitance 1.22654e-10
      dc_inductance  3.17252e-07
      dc_impedance   50.8583
      port_excited yes
      group      Mode1:output1
      user_label Port 1
      dB 20

  to Port 1: Output
    type  complex
    units √W
    parameters
      port_name   1
      port_cutoff 0
      dc_capacitance 1.22654e-10
      dc_inductance  3.17252e-07
      dc_impedance   50.8583
      port_excited yes
      group      Mode1:output1
      user_label Port 1
      dB 20

  to Port 1: Phase shift
    type  real
    units radians
    parameters
      port_name   1
      port_cutoff 0
      dc_capacitance 1.22654e-10
      dc_inductance  3.17252e-07
      dc_impedance   50.8583
      port_excited yes
      group      Mode1:output1
      user_label Port 1
      from 0 0.0575926 0.01125
      to   0 0.040177 0.01125
      real_block -3.045000e-02  3.045000e-02  3.800000e-02  5.976960e-02 -9.999810e-05  2.260000e-02

  to Port 1: Zchar
    type  complex
    units Ohm
    parameters
      port_name   1
      port_cutoff 0
      dc_capacitance 1.22654e-10
      dc_inductance  3.17252e-07
      dc_impedance   50.8583
      port_excited yes
      group      Mode1:output1
      user_label Port 1

  to Port 1: beta
    type  complex
    units radian/m
    parameters
      port_name   1
      port_cutoff 0
      dc_capacitance 1.22654e-10
      dc_inductance  3.17252e-07
      dc_impedance   50.8583
      port_excited yes
      group      Mode1:output1
      user_label Port 1

  to Port 1: Phase Velocity / c
    type  real
    parameters
      port_name   1
      port_cutoff 0
      dc_capacitance 1.22654e-10
      dc_inductance  3.17252e-07
      dc_impedance   50.8583
      port_excited yes
      group      Mode1:output1
      user_label Port 1

  to Port 1: accepted power
    type  real
    units W
    parameters
      port_name   1
      port_cutoff 0
      dc_capacitance 1.22654e-10
      dc_inductance  3.17252e-07
      dc_impedance   50.8583
      port_excited yes
      group      Mode1:output1
      user_label Port 1
      dB 10

  to Port 1: termination return
    type  complex
    parameters
      port_name   1
      port_cutoff 0
      dc_capacitance 1.22654e-10
      dc_inductance  3.17252e-07
      dc_impedance   50.8583
      port_excited yes
      group      Mode1:output1
      user_label Port 1
      dB 20

  table

{bytes 2772
  table_as_binary 49(14r /)
Nʧ�>��8�h�9�6}�?6^���$4BS D�   B��(��*i?l�>O����eU�?�N�'
>�D�g�H�(&�?4
����BSBM?��NB�z����?i�>W'D���ҾmaN˦2>³��h$�k�?2�����BS|h?���B�a˿��x?h*>_1��I'���%N�%Z>�;,�h���v6?0�k��D�BS�P?�F�B�������?g�>g�ҿ�쒾�4eN̤�>���h� ���W?.A\���@BS�F?���B�
뿟�s?h>p�¿����UsN�#�>��iaN�)}�?+$����>BT&�?~��B�]s��Qa?j>z�ʿ�CǾ�3N͢�>�k�i��B��?'m$��X�BT[X?td�B��q��^.?m�>�cd���2�	�N�!�>����j)N<��?#�����BT��?hl�B������B?r�>���������NΡ#>��[�j��=3�?3 ��KBT�i?Z�FB�K@���?y�>�;ӿ����/�pN� K>�y�j�'=���?����[vBT�?K�yB��ÿ��@?�~>���_��D�#Nϟs>�A>�k5�=��@?�����HBU?;t�B��+��k@?�]>�π��K��[n�N��>�b.�k�1=�)�?&{����BU"�?)��B�'S��%O?�f>�����M�s��NН�>��k�f>
�l?#���IBBU7�?��B�l���,?��>����l&��A�N��>��R�l�>��>�k����2BUD�?�+B��r��M�?�Y>�����������Nќ>���lU>+�W>�Ա���VBUHl>�r4B��E�߀}?�a>�;��ƿ�ɰN�;>��"�l��>8:H>ۣ����BUBR>��B�+���@�?��>�.����Y���(NҚc>��l��>A}>�����`uBU1�>��B�f���d?�]>�-?�ɵt��`3N��>�Fw�m�>G�k>�Z����BU�>8,{B��g�?>�
���	���͹NӘ�>��n�m7)>Jt1>��I���BT�=�D�B��\��7?5c>Ⱥ̿�፿�o�N��>�ܥ�ml�>J>��>���BT�I<��ZB���RR?S>�2J��m`��.Nԗ>�>�m��>F9
>��{��S\BTk�SL!B�@���Es?q�>�e������^N�,>���m��>? 8>l[ݿ���BT98���B�tӿ���?�0>�I߿��-�2�dNՕT>�.��n�>4�>L+<���3BS�f�/�2B��[��e?��>�Ԅ�� <�LuN�|>��q�nSj>'@�>-YͿ��BS��^\�B�ޒ��g?�/>��ӿ�l;�l��N֓�>�S�n�\>�_>;w��?�BSA����TB�ο�Ʌ?�>����(��"RN��>��n�->Tu=�?���}�BR괾��fB�L,��Q?	>��������i]Nב�>���o@=ڤB=������BR�[����B�������?	Z>��;�*\-���N�>�=Q�oe�=��t=� 쿝�OBRC��� �B��ȿ��<?	7�>���X�X��ONؐD>��'�o��=i˴=Ji���<�BQ�Q��O�B��b���-?	P�>�������?'�N�l>��s�o��<�SI=����|�BQ����jwB�0��ˆ?	i�>���6�O��DUNَ�>�%ۿp9�9�O�<�\ſ��_BQs2�y��B�j���z?	��>�Ǌ�7���s�(N��>����p{���<+�����CBQ=�\��B�����6�?	��>��g����A�A<Nڌ�>�V��p�9�x�G;�����99BQ��:C�B����F�?	�H>�����<Aq�UN�>�籿p�����5:5ǿ�vaBP��B����"w?	�y>�IvA#�Nۋ5>�t��q(���7�:M�����BPϰ�ւ�B�Gn���p?	��>�/���@�V�N�
]>��\�qX$���;��?����BP�����B�~��3#?
	H>�@c��@�MN܉�>����q�o�>�<1=��-�BP�6��S�B��o��qD?
#�>��:��o�@�b]N��>��q��\�@<��&��mDBP�-<�-�B��|���R?
<x>��y��S@�/sN݇�>����q�C�y��=������BP�j=\�B�)����8?
R�>�6���K@iӰN��>��y�q�����=H���jBPŒ=��}B�h��o֐?
f>�f�ǖ�@M*=Nކ%>�n�r8���&=��o��?]BP� =��B����^�T?
u�>���� �@6UN�M>��:�r4���=��ƿ���BP��>	�8B��Z�N��?
�v>��y��z @"�7N߄v>�AO�r2y��`}=�����BP�^>��B�;ӿ?A�?
�@>�0d���C@��N��>����rH-���>
����8>BQ�>"�B��D�1$?
�:>�h���=�@�%N���>�m�r\)��3�>%�����BQ�>%�4B��Y�$H�?
��>�t��'=?�Y�N��>|�T�rn��g>A������BQ*�>$��B�1���?
�0>�^"��E?�
^N�>y��r}N�̪�>_1f��T�BQ2:> #cB����o�?
�>�1Ϳ���?�7N� >>u�ǿr�@��ѧ>}M����}BQ4�>*�B���[??
~�>�������?��DN�f>r��r�;�ӕZ>��P�� BQ2�>�B�?��� ?
v >��=��H�?��G
}
