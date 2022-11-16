using Microsoft.AspNetCore.Identity;

namespace MagicVilla_VillaAPI.Models.Dto
{
    public class UserDTO
    {
        public string ID { get; set; } 
        public string UserName { get; set; }
        public string Name { get; set; }
        public string Role { get; set; }
        public IEnumerable<IdentityError> ErrorMessages { get; set; }
    }
}
