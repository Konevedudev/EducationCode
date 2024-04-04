local mps = game:GetService("MarketplaceService")
-- Замените 00000000 на ID своего игрового пропуска
local id = 773944612
local pet = game.ReplicatedStorage:FindFirstChild("PetBad") -- Обязательно поменять имя пета

-- функция для обработки завершения покупки игрового пропуска
mps.PromptGamePassPurchaseFinished:Connect(function(player, passId, wasPurchased)
	-- Проверяем, была ли покупка совершена успешно и соответствует ли ID пропуска нашему ID
	if wasPurchased and passId == id then
		-- Если условие выполняется, вызываем функцию addPet для игрока
		addPet(player)
	end
end)
-- Обработка события подключения игрока к игре
game.Players.PlayerAdded:Connect(function(player)
	-- Ждем 1 секунду загрузки игрока
	wait(1)
	-- Проверяем, что игрок уже имеет игровой пропуск
	if mps:UserOwnsGamePassAsync(player.UserId, id) then
		-- Если игрок имеет пропуск, вызываем функцию addPet для игрока
		addPet(player)
	end
end)


function addPet(player)
	if player then
		local character = player.Character
		if character then
			local humanrootpart = character.HumanoidRootPart
			local newpet = pet:Clone()
			newpet.Parent = character
			local bodyPos = Instance.new("BodyPosition", newpet)
			bodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			local bodyGyro = Instance.new("BodyGyro", newpet)
			bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
			while wait() do
				bodyPos.Position = humanrootpart.Position + Vector3.new(3,2,3)
				bodyGyro.CFrame = humanrootpart.CFrame
			end
		end		
	end
end