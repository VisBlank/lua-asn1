--[[
Copyright (c) 2015 Kaarle Ritvanen
See LICENSE file for license details
--]]

local asn1 = require('asn1')

local M = {}

M.KeyIdentifier = asn1.octet_string()

M.AuthorityKeyIdentifier = asn1.sequence{
   {'keyIdentifier', asn1.explicit(0, M.KeyIdentifier)}
}

M.CRLDistributionPoints = asn1.sequence_of(
   asn1.sequence{
      {
	 'distributionPoint',
	 asn1.explicit(
	    0,
	    asn1.choice{
	       {
		  'fullName',
		  asn1.sequence_of(
		     asn1.choice{
			{'uniformResourceIdentifier', asn1.ia5string{tag=6}}
		     },
		     {tag=0, min=1}
		  )
	       }
	    }
	 )
      }
   },
   {min=1}
)

return M