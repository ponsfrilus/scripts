#!/usr/bin/php
<?php

/**
 * Connect to the ldap
 * @param $ldap       ldap.epfl.ch
 * @param $dn         "o=epfl,c=ch"
 * @param $filter     "(&(objectclass=organizationalunit))"
 * @param $attributes array() //array("ou", "sn", "givenname", "mail");
 * @return ldap entries
 **/
function ldapsearch($ldap="ldap.epfl.ch", $dn="o=epfl,c=ch", $filter="(&(objectclass=organizationalunit))", $attributes=array()) {
  $ds=ldap_connect($ldap);
  //print "----" . $dn;
  if ($ds) {
    $r=ldap_bind($ds);
    //$filter="(&(objectclass=organizationalunit)(ou=igm-ge))";
    /*print $dn . "\n";
    print $filter . "\n";
    print_r($attributes) . "\n";
    print "-----\n" ;*/

    $sr = ldap_search($ds, $dn, $filter, $attributes);
    //echo 'Get  ' . ldap_count_entries($ds,$sr) . " entries\n";
    return ldap_get_entries($ds, $sr);
  } else {
    throw new Exception("LDAP problem");
  }
}

function getEPFLUnitsArray($top_ou="", $second_ou="") {
  $bigArrayofUnits = array();
  $bigArrayofUnits['ch'] = array();
  $bigArrayofUnits['ch']['epfl'] = array();
  $dn = "o=epfl,c=ch";
  if ($top_ou != '') {
    $dn = "ou=" . $top_ou . "," . $dn;
  }
  if ($second_ou != '') {
    $dn = "ou=" . $second_ou . "," . $dn;
  }
  $ldapdata = ldapsearch("ldap.epfl.ch", $dn, "(&(objectclass=organizationalunit))", array());
  foreach ($ldapdata as $v) {
    // print($v['dn']);
    $pieces = array_reverse(explode(",", $v['dn']));
    array_shift($pieces); // remove c=ch
    array_shift($pieces); // remove o=epfl
    // print_r($pieces);
    // print count($pieces) . "\n";
    // print $pieces[0] . "\n";
    if (isset($pieces[0])) {      // FACULTIES
      $top_level = explode("=", $pieces[0])[1];
      if (!isset($bigArrayofUnits['ch']['epfl'][$top_level])) {
        $bigArrayofUnits['ch']['epfl'][$top_level] = array();
      }

      if (isset($pieces[1])) {    // INSTITUTS
        $second_level = explode("=", $pieces[1])[1];
        if (!isset($bigArrayofUnits['ch']['epfl'][$top_level][$second_level])) {
          $bigArrayofUnits['ch']['epfl'][$top_level][$second_level] = array();
        }

        if (isset($pieces[2])) {  // LABS
          $third_level = explode("=", $pieces[2])[1];
          if (!isset($bigArrayofUnits['ch']['epfl'][$top_level][$second_level][$third_level])) {
            $bigArrayofUnits['ch']['epfl'][$top_level][$second_level][$third_level] = array();
          }
        }
      }
    }
  }
  //print_r($bigArrayofUnits);
  //print count($bigArrayofUnits['ch']['epfl']['sti']['igm']);
  return $bigArrayofUnits;
}

function getSizeOfUnit($faculty="", $institut="", $mode="") {
  $bigArrayofUnits = getEPFLUnitsArray($faculty, $institut);
  $summary = array();
  foreach ($bigArrayofUnits["ch"]["epfl"] as $k => $v) {
    $bigArrayofUnits["ch"]["epfl"][$k]['total'] = count($v);
    $summary[$k] = array("__count__"=>count($v));
    if (is_array($v)) {
      foreach ($v as $vk => $vv) {
        $bigArrayofUnits["ch"]["epfl"][$k][$vk]['total'] = count($vv);
        $summary[$k][$vk] = count($vv);
      }
    }
  }
  //print count($bigArrayofUnits['ch']['epfl']['sti']['igm']);
  //print_r($summary);
  if ($mode == "summary") {
    return $summary;
  } else {
    return $bigArrayofUnits;
  }
}

function getMembersOfUnit($faculty="", $institut="", $mode="") {
  $bigArrayofUnits = getEPFLUnitsArray($faculty, $institut);
  $summary = array();
  foreach ($bigArrayofUnits["ch"]["epfl"] as $k => $v) {
    // FACULTIES
    $bigArrayofUnits["ch"]["epfl"][$k]['_unit_count'] = count($v);
    $summary[$k] = array("_unit_count"=>count($v));
    if (is_array($v)) {
      // INSTITUTES
      foreach ($v as $vk => $vv) {
        $bigArrayofUnits["ch"]["epfl"][$k][$vk]['_unit_count'] = count($vv);
        $summary[$k][$vk]['_unit_count'] = count($vv);

        if (is_array($vv)) {
          // UNITS
          foreach ($vv as $vvk => $vvv) {
            $current_ou = "ou=" . $vvk . ",ou=" . $vk . ",ou=" . $k . ",o=epfl,c=ch";
            $pplcount = getCountOfUnit($current_ou);
            $bigArrayofUnits["ch"]["epfl"][$k][$vk][$vvk]['_ppl_count'] = $pplcount;
            $summary[$k][$vk][$vvk] = $pplcount;
            $summary[$k][$vk]['_unit_count'] += $pplcount;
          }
        }
      }
    }
  }
  //print count($bigArrayofUnits['ch']['epfl']['sti']['igm']);
  //print_r($summary);
  if ($mode == "summary") {
    return $summary;
  } else {
    return $bigArrayofUnits;
  }
}

function getCountOfUnit($ou='o=epfl,c=ch') {
  return (ldapsearch("ldap.epfl.ch", $ou, "(objectClass=person)", array("uniqueIdentifier")))['count'];
}

function old($info) {

  $units = array();
  for ($i=0; $i<$info["count"]; $i++) {
    //print_r($info);
    $dn_ou = explode(",", $info[$i]['dn']);
    // remove c=ch
    array_pop($dn_ou);
    // remove o=epfl
    array_pop($dn_ou);
    // remove itself
    array_shift($dn_ou);
    $parents = array();
    foreach ($dn_ou as $key => $val) {
      $parents[] = substr($val, 3, strlen($val));
    }
    if (isset($info[$i]['labeleduri'][0])) {
      $url = strstr($info[$i]['labeleduri'][0], ' ', true);
      $url_desc = trim(strstr($info[$i]['labeleduri'][0], ' '));
    } else {
      $url = $url_desc = '';
    }
    if (isset($info[$i]['uniqueidentifier'][0])) {
      $units[$info[$i]['uniqueidentifier'][0]] = array (
        'cn' => $info[$i]['cn'][0],
        'unit' => $info[$i]['ou'][0],
        'uniqueidentifier' => $info[$i]['uniqueidentifier'][0],
        'gidnumber' => isset($info[$i]['gidnumber'][0]) ? $info[$i]['gidnumber'][0] : '',
        'accountingnumber' => isset($info[$i]['accountingnumber'][0]) ? $info[$i]['accountingnumber'][0] : '',
        'description' => isset($info[$i]['description'][0]) ? $info[$i]['description'][0] : '',
        'description_en' => isset($info[$i]['ou;lang-en'][0]) ? $info[$i]['ou;lang-en'][0] : '',
        //'uri' => $info[$i]['labeleduri'][0],
        'url' => $url,
        'url_desc' => $url_desc,
        'dn' => $info[$i]['dn'],
        'first_parent' => isset($parents[0]) ? $parents[0] : '',
        'parents' => $parents,
      );
    }
  }

  // create json cache
  $junits = array();
  foreach($units as $uk => $uv) {
    $junits[$uk] = $uv['unit'].': '.$uv['description_en'];
  }
  // sort by unit name
  asort($junits);
  // reorganise array for correct json format
  $jau = array();
  foreach ($junits as $key => $value) {
    $jau[] = array('id' => $key, 'text' => $value);
  }

  //$json_unit = json_encode($junits);
  //http://php.net/manual/fr/function.json-encode.php#105923
  $json_unit = json_encode($jau);
  //  str_replace('\'', '\\\'',
  print "JSON output:<br /><pre>";
  print_r($json_unit);
  // create cache file
  $cache = fopen($this->unit_cache_json_file, 'r+');
  fputs($cache, $json_unit);
  fclose($cache);

  // Create serialized cache
  print "PHP output:<pre>";
  print_r($units);
  // create cache file
  $cache = fopen($this->unit_cache_file, 'r+');
  fputs($cache, serialize($units));
  fclose($cache);

  // Close
  ldap_close($ds);

}


//old(ldapsearch());
//print_r(getEPFLUnitsArray());
//print_r(getSizeOfUnit("sti", '', 'summary'));
//print getCountOfUnit("ou=unfold,ou=igm,ou=sti,o=epfl,c=ch");
//print_r(ldapsearch());
print_r(getMembersOfUnit("", '', 'summary'));
