data_id

!solution_id  17-January-2020  15:51:53

function time domain port 1 excited
  parameters
    cutoff_frequency  0.190000E+10
    frequency_range  0.170000E+10 0.190000E+10
    unfiltered_end  0.656897E-08
    unfiltered_excitation_end  0.328943E-08
    filter_rise_time  0.328943E-08
    port_excited 1
    variable Mt
      value  0.100000E+00
    variable h
      value  0.450000E+01
    variable Gpf
      value  0.100000E+01
    variable Fi
      value  0.125000E+02
    variable Wf
      value  0.870000E+01
    variable Lf
      value  0.315000E+02
    variable W
      value  0.510000E+02
    variable L
      value  0.380000E+02
    excitation_label 1

  from time
    type real
    units s

  to voltage:(Mode1:output1)
    type real
    units V
    !parameters
      real_block -0.304500E-01  0.304500E-01  0.554157E-01  0.597696E-01 -0.999981E-04  0.226000E-01
      port_cutoff  0.000000E+00
      dc_capacitance  1.226535E-10
      dc_inductance  3.172520E-07
      dc_impedance  5.085834E+01
      port_name 1
      port_excited yes
      quantity voltage
      group Mode1:output1
      user_label Port 1
  to current:(Mode1:output1)
    type real
    units A
    !parameters
      real_block -0.304500E-01  0.304500E-01  0.554157E-01  0.597696E-01 -0.999981E-04  0.226000E-01
      port_cutoff  0.000000E+00
      dc_capacitance  1.226535E-10
      dc_inductance  3.172520E-07
      dc_impedance  5.085834E+01
      port_name 1
      port_excited yes
      quantity current
      group Mode1:output1
      user_label Port 1
  to voltage:(Mode1:output2)
    type real
    units V
    !parameters
      real_block -0.304500E-01  0.304500E-01  0.380000E-01  0.423539E-01 -0.999981E-04  0.226000E-01
      port_cutoff  0.000000E+00
      dc_capacitance  1.226535E-10
      dc_inductance  3.172520E-07
      dc_impedance  5.085834E+01
      port_name 1
      port_excited yes
      quantity voltage
      group Mode1:output2
  to current:(Mode1:output2)
    type real
    units A
    !parameters
      real_block -0.304500E-01  0.304500E-01  0.380000E-01  0.423539E-01 -0.999981E-04  0.226000E-01
      port_cutoff  0.000000E+00
      dc_capacitance  1.226535E-10
      dc_inductance  3.172520E-07
      dc_impedance  5.085834E+01
      port_name 1
      port_excited yes
      quantity current
      group Mode1:output2
  to voltage:(Mode1:output3)
    type real
    units V
    !parameters
      real_block -0.304500E-01  0.304500E-01  0.467078E-01  0.510618E-01 -0.999981E-04  0.226000E-01
      port_cutoff  0.000000E+00
      dc_capacitance  1.226535E-10
      dc_inductance  3.172520E-07
      dc_impedance  5.085834E+01
      port_name 1
      port_excited yes
      quantity voltage
      group Mode1:output3
  to current:(Mode1:output3)
    type real
    units A
    !parameters
      real_block -0.304500E-01  0.304500E-01  0.467078E-01  0.510618E-01 -0.999981E-04  0.226000E-01
      port_cutoff  0.000000E+00
      dc_capacitance  1.226535E-10
      dc_inductance  3.172520E-07
      dc_impedance  5.085834E+01
      port_name 1
      port_excited yes
      quantity current
      group Mode1:output3
  table
{
table_as_binary           76(           7r/)
�a�K�۾L�N𽐟��{\� r(����X��
ɭ�'�W=���=���B��?��v�O����j�5Än���
����9c��F��EJb\Bt(â����ʺD�ϻA��4�=�I�@��b,vEoӊB��#EJdBv�
�4�	Ƥ������z��,ƒ�Pó\�+��G��zD��
�e÷Ï��F��1C�s��"�����6�	�HG�CD�xG�fD��ޱ{G��B��	�$��JO��Kȵ�����r�tI��oF���Ȳ����lHY_�Er8�l�G���E	7OI�9F�W|I�d�G�������-���Ɋ��ƪ��ʐ��Ǭ�B�꼋K8��H[.|ʧb���ҡIFĂFưخJ���G�#�Ko�9H��K���H��0�Ɵ��a�Ɇ]ʢ<yǷ�d����.�����	L�Z�I�;��E��Ʉ�������]@~����L�{�I��L�ԯJ�Mq$J.�,��tͬM%�ɇdư��H+=��N���f*\�|�M���J�i�͙v;���L�ދ@�-w6�X�M�2K
y�M�yaK�N;-�K_#-�4�	μ=J�א�M~�J����HO��KJ�tN`��K��nΩ�'��L�:*ˈdʯخO�L&y�N�RUL@2O>?LY���tϸk���N��eK�l��^��Uj�tO<5LK&&ϲq�:�ϊ�̻E�    P�)N	�O��+M~�P���M���/tP�p�Nl�P︅N P���N%�W/�tί�FK�D#P�|�MŴ�P!3�MC�</خ�s���Y"ϟ��ːM[ϓT��0tε�~MXТ�M�s��"$Mc��04�	З-�M����hXeM�wЖ9M�\z0X���AM���O9R�̙m�����L���0|�O�l�槉PFP�͐}MP=v�m�0�tPSK��y�7PPD�#\�P:�4�L�F0���P���/מP;u�9�8Pik�.�!0��	P(�?� O�t�!��P���@�!0Ɵ�O�0���N�Ah˪�}Oc~�̄C0خND4=ˉgtO���̪`$N�4��gV0꼋O�����P�B�;X�PJ��*$�0��P���4��OR̅1O������1l�N�Z����KO(KV����k�J��1tͿ�J�;�OoS�̍N�u���CR1{GO�M̫��O�����v&O������\1"��O�ލ�Ƨ�O5
�A�Ox�̘v1+��N����X��_ɒB�N+'��a??14�	���<I���N�&˘]L��	8�1=�IN����*Of��̈�JO.Vy�P��1F��Om�e̐H�O���6)�OZ�̅^&1O��N������$K�M������1X��%��KAHJM�B�դ���(5K
W�1a�KN=e_�bB�Of��(<�N�_,����1j��O'�2�Nα~��<�O
Z�(�1s��N�s��Ñ3�H��N�<�1|��r�ZJ��F�P�zJm��֛wJ�BD1��&�r�tH���N���˳=�N��/�|1�l�N�B�ӗ�N���ӿ�N����e�1��gN��H˹�-˓ Sȱ�jN~�<��1�t�K�5Jcv@ͨ�PJN��`ZK_�1����N(�J{N(2��Du�M`��ʁ�1�{GNJ9D�s8�Nmq2ˍ�/Nz�4˗W�1���NV�˃�M�<�M�N�+�&�1���K	[,��rV͜��J�ع�whJ��1�(͊�J���MvHʍ��̇�I��1���M�:k�ݕN-���NS�NǢ�8��1�iN&e��JQMC�/�z��M��!���1��	L�_���\̓H�J��� J81���}��J�i�L�ɘw|�
�`J+`�1��IM6��:nM����d�M���·1��M�?��#�MPB�ʁM�������1Ɵ�M�z�&Q��$�J:l�7ٔI@ +1�#*�7I{J[��?�MInY�� P�JB�X1Ϧ�KDk�B��M�<ʢM$G{�BT1�*jM�D�ʳ/MCǊ�n7�M���ʮ��1خMH+�1�����)I�Y�J���g`�1�1����AJ��̝4�I���	J%N�1�K�#��IL0�M0��4��L<�ɓ��
}
