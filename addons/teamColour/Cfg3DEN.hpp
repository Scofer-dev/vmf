#include "script_component.hpp"

class Cfg3DEN {
	class Object { //https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes
		class AttributeCategories {
			class voidMissionFramework {
				displayName = "Void Mission Framework";
				collapsed = 1;
				class Attributes {
					class teamColour { //https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes:_Controls#Combo
						control = "COMBO";
						property = "VMF_teamColour";
						displayName = "Team Colour";
						tooltip = "What team colour will the unit have";
						expression = "if !(is3DEN) then {_this setVariable ['VMF_teamColour',_value,true]}"; //In MP only called on server
						defaultValue = "'MAIN'";
						typeName = "STRING";
						condition = "objectControllable";

						class Values { //https://community.bistudio.com/wiki/assignTeam
							class White {
								name = "White";
								value = "MAIN";
							};
							class Red {
								name = "Red";
								value = "RED";
							};
							class Green {
								name = "Green";
								value = "GREEN";
							};
							class Blue {
								name = "Blue";
								value = "BLUE";
							};
							class Yellow {
								name = "Yellow";
								value = "YELLOW";
							};
						};
					};
				};
			};
		};
	};
};
