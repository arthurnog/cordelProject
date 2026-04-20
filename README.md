# cordelProject

Modificações devem ser mergeadas na branch dev antes de irem pra main

Estrutura de pastas:
├── assets/                # Arquivos brutos (importados pelo Godot)
│   ├── audio/             # Música (.ogg) e SFX (.wav)
│   ├── fonts/             # Fontes (.ttf, .otf)
│   ├── sprites/           # Personagens, cenários e itens (PNG/Aseprite)
│   └── shaders/           # Efeitos visuais e materiais
│
├── common/                # Recursos compartilhados por todo o projeto
│   ├── components/        # Nós reutilizáveis (Hitbox, Hurtbox, HealthComponent)
│   ├── shaders/           # Shaders globais (ex: flash de dano, contorno)
│   └── themes/            # Temas de UI e estilos de botões
│
├── entities/              # "Atores" do jogo (Cenas + Scripts locais)
│   ├── player/            # O jogador (Axel, Blaze, etc.)
│   ├── enemies/           # Inimigos (divididos por tipo ou tier)
│   │   ├── grunt/         # Inimigo básico
│   │   └── boss_01/       # Primeiro chefe
│   └── npc/               # Personagens não jogáveis
│
├── levels/                # Fases do jogo
│   ├── base_level.tscn    # Cena base com lógica de câmera/limites
│   ├── stage_01/          # Rua, esgotos, etc.
│   └── stage_02/
│
├── objects/               # Coisas que aparecem nas fases
│   ├── breakables/        # Caixotes, latas de lixo, cabines
│   ├── items/             # Comida (cura), armas coletáveis, dinheiro
│   └── hazards/           # Armadilhas no cenário (buracos, eletricidade)
│
├── resources/             # Dados do jogo (Custom Resources .tres)
│   ├── character_stats/   # Vida, força, velocidade de cada entidade
│   └── move_data/         # Dados de combos e frames de ataque
│
├── ui/                    # Interface de Usuário
│   ├── hud/               # Barras de vida, contador de combo, timer
│   ├── menus/             # Menu principal, pausa, seleção de personagem
│   └── screens/           # Game Over, vitória, transições
│
└── autoloads/             # Scripts globais (Singletons)
	├── game_manager.gd    # Pontuação, progresso da fase
	├── sound_manager.gd   # Controle central de áudio
	└── signal_bus.gd      # Central de sinais (Event Bus)
