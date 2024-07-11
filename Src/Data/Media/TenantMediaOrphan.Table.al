table 58100 "Tenant Media Orphan  WLD"
{
    Caption = 'Tenant Media Orphan';
    Scope = Cloud;

    fields
    {
        field(1; MediaID; Guid)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            TableRelation = "Tenant Media";
        }
        field(2; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; Content; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Content';
            SubType = Bitmap;
        }
        field(4; "Mime Type"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Mime Type';
        }
        field(5; Height; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Height';
        }
        field(6; Width; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Width';
        }
        field(7; "Company Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Company Name';
            TableRelation = Company.Name;
        }
        field(8; "Expiration Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiration Date';
        }
        field(10; "Prohibit Cache"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prohibit Cache';
        }
        field(11; "File Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'File Name';
        }
        field(12; "Security Token"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Security Token';
        }
        field(13; "Creating User"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Creating User';
        }
        field(100; Select; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Select';
        }
        field(101; Length; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Length';
        }
    }

    keys
    {
        key(Key1; MediaId)
        {
            Clustered = true;
        }
    }

}

