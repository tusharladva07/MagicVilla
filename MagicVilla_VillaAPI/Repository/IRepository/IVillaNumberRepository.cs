using MagicVilla_VillaAPI.Models;
using System.Linq.Expressions;

namespace MagicVilla_VillaAPI.Repository.IRepository
{
    public interface IVillaNumberRepository : IRepository<VillaNumbers>
    {

        Task<VillaNumbers> UpdteAsync(VillaNumbers entity);

    }
}
