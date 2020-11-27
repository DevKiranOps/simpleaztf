#!/bin/bash


# Get variable variables from varfile. 
source ./varfile


# Creating Resource Group
az group create --name $rg_name --location $location 

# Creating Virtual Network with a subnet
az network vnet create --name $vnet_name   \
   --address-prefixes $vnet_cidr\
   --resource-group $rg_name --subnet-name $subnet1 \
   --subnet-prefixes $subnet1_cidr





# Creating Web server in subnet1 - Make sure you create an Environment variable for PASSWD 

for i in {0..2}
do
    az network public_ip create
        --resource-group $rg_name \
        --name web-ip-$i \      
        --addres_ip_allocation dyanmic
done

web-ip-0
web-ip-1
web-ip-2



for i in {0..2} 
do
    az network nic create 
        --resource-group $rg_name \
        --name web-nic-$i \
        --vnet-name $vnet_name  \
        --subnet $subnet1  
        --public-ip web-ip-$i
done


web-nic-0
web-nic-1
web-nic-2




for i in {0..2} 
do

    az vm create \
    --resource-group $rg_name \
    --name webserver-$i \
    --nic web-nic-$i \
    --image UbuntuLTS \
    --admin-username $username \
    --vnet-name $vnet_name  \
    --subnet $subnet1  \
    --ssh-key-values /opt/class/keys/xyz.pub
    
done



        
