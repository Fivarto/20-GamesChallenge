extends Area2D
class_name  Vehicle

@onready var vehicle_sprite: Sprite2D = $VehicleSprite


#FUNÇÃO PARA DEFINIR O SPRITE DO VEICULO
func set_vehicle_texture(texture: Texture2D):
	vehicle_sprite.texture = texture
